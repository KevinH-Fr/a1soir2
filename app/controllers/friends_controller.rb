class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]

  # GET /friends or /friends.json
  def index
    @friends = Friend.all

    respond_to do |format|
      format.html
        format.pdf do
          pdf = Grover.new(url_for()).to_pdf
          customFilename = "friends" ".pdf"
          send_data(pdf, disposition: 'inline', filename: customFilename, 
                          type: 'application/pdf', format: 'A4')
        end

        format.png do
         #  png = Grover.new('http://localhost:3000/friends').to_png
          png = Grover.new(url_for(only_path: false)).to_png
          send_data(png, disposition: 'inline', filename: "filename.png", type: 'application/png')

          #   png = Grover.new(url_for()).to_png
       #   customFilename = "friends" ".png"
       #   send_data(png, disposition: 'inline', filename: customFilename, 
       #                   type: 'application/png', format: 'A4')
        end
    end

  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:nom, :mail, :age)
    end
end
