class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @model = params[:model] #検索時に必要な変数を用意
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content,@method)
    else
      @records = Book.search_for(@content,@method)
    end
  end
end
