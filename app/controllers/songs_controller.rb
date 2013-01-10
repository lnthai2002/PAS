require 'tag_info.rb'
class SongsController < ApplicationController
  set_tab :music
  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
      format.mp3 {
        file = File.read(@song.location)
        send_data(file, :type => "audio/mpeg", :filename => "#{@song.id}.mp3", :disposition => "inline")
      }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    params[:song].each do |tag, value|
      if TagInfo::USEFULL_TAGS.include?(tag)#tag on file is a useful tag
        @song[tag] = value #update the useful tag in DB
      end
    end
    respond_to do |format|
      begin
        Song.transaction do #update both file and DB or neither
          @song.update_tags_on_file(params[:song])
          @song.save!
        end
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :ok }
      rescue Exception=>e
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :ok }
    end
  end

  def scan
    Resque.enqueue(DiskCrawler, params[:folder])
  end

  def search
    if params[:search]
      conds = []
      if not params[:search][:title].blank?
        conds << {'title'=>params[:search][:title]}
      end
      if not params[:search][:artist].blank?
        conds << {'artist'=>params[:search][:artist]}
      end
      if not params[:search][:album].blank?
        conds << {'album'=>params[:search][:album]}
      end
      if not params[:search][:genre].blank?
        conds << {'genre'=>params[:search][:genre]}
      end
      conds.each do |column, filter|
        filter = filter.gsub(' ', '%')
      end
      @results = Song.paginate(:all, :conditions=>conds, :page=>page)
    end
  end
=begin
  def download
    id = File.basename(params[:id],File.extname(params[:id]))
    @song = Song.find(id)
    file = File.read(@song.location)
    send_data(file, :type => "audio/mpeg", :filename => "#{@song.id}.mp3", :disposition => "inline")
  end
=end
end
