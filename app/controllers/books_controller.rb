class BooksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :like, :unlike ]
  before_action :set_book, only: [:show, :edit, :update, :destroy, :like, :unlike, :undislike, :dislike]

  # GET /books
  # GET /books.json
  def index
    @books = Book.order("created_at DESC").all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    
    # Prendo in input dall'utente il codice ISBN
    isbn = book_params[:isbn]
    
    # Controllo che il libro non sia già presente nella lista dei libri aggiunti dall utente
    duplicate_flag = false
    
    current_user.books.each do |book|
      if book.isbn == isbn
        duplicate_flag=true
      end
    end

    if duplicate_flag
      flash[:alert] = "You already added this book, check your Books list!"
      redirect_to profile_path(current_user.profile_name)
    else
      
      # Inizializzo l'URI inserendo i'isbn e invio la richiesta
      uri = URI.parse('https://www.googleapis.com/books/v1/volumes?q=isbn:'+isbn+'&amp;language=it')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      count = JSON.parse(res.body)["totalItems"]
      if count==0
        render file: 'public/404', status: 404, formats: [:html]
      else
        # Parsing della risposta in JSON e prendo il campo ITEMS/VOLUMEINFO
        items = JSON.parse(res.body)["items"][0]["volumeInfo"]
      
        # Salvo i valori che ci interessano in variabili di istanza (in modo da renderle accessibili anche dalla view, non è necessario ma potrebbe servire)
        @title = items["title"]
        @author = items["authors"][0]
        # Per evitare errori in caso non ci sia l'immagine della copertina (in seguito si può cercare su altri siti)
        if items.has_key?("imageLinks")
          @cover = items["imageLinks"]["thumbnail"]
        end
      
        # Debug info
        puts @title
        puts @description
      
        @description = items["description"]
      
        # I libri in italiano (la maggior parte almeno) non hanno descrizione su googleapi.com quindi in caso sia nil andiamo a cercarla su wikipedia
        if @description.nil?
        
          uri2 = URI('https://it.wikipedia.org/w/api.php?action=query&titles='+@title+'&prop=revisions&rvprop=content&format=json&redirects=1')
          rest = Net::HTTP.get_response(uri2)
        
        
        
        # Da rivedere eventualmente perchè in alcuni casi da errore (in particolare bisogna analizzare più risultati e vedere come è impostato il campo revisions)
          page_id = JSON.parse(rest.body)["query"]["pages"].first
          puts page_id
          puts page_id[0]
          if page_id[0]!="-1"
            desc = page_id.last["revisions"][0]["*"]
          
            # La response di Wikipedia è in WikiText (formato loro) quindi uso una gem (Wikitext) per parsare il contenuto in formato leggibile
            @description = Wikitext::Parser.new.parse(desc)
          
            # Alcuni caratteri non vengono analizzati dal parser quindi vanno sostituiti manualmente almeno per ora.
            @description.sub! "{{div col}}" , ""
            @description.sub! "{{div col end}}" , ""
            @description.gsub! "{{" , ""
            @description.gsub! "}}" , ""
            @description.gsub! "|" , '<br>'
          end
        end
        @book = current_user.books.new(book_params)
      
      
  
        respond_to do |format|
          if @book.save
            if @description.nil?
              @description = '<strong><a href="https://bloggerz-lucianolo.c9users.io/books/'+@book.id.to_s+'/edit">Add a description</a><strong>'
            end
            @book.update(author: @author, title: @title, description: @description, cover_uri: @cover)
            format.html { redirect_to @book, notice: 'Book was successfully created.' }
            format.json { render :show, status: :created, location: @book }
          else
            format.html { render :new }
            format.json { render json: @book.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(add_book_description)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def like
    @book = Book.find(params[:id])
    @book.liked_by current_user
    redirect_to books_path
  end
  
  def dislike
    @book = Book.find(params[:id])
    @book.disliked_by current_user
    redirect_to books_path
  end
  
  def unlike
    @book = Book.find(params[:id])
    @book.unliked_by current_user
    redirect_to books_path
  end
  
  def undislike
    @book = Book.find(params[:id])
    @book.undisliked_by current_user
    redirect_to books_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:user_id, :isbn)
    end
    
    def add_book_description
      params.require(:book).permit(:description)
    end
end
