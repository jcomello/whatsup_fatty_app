class InsultsController < ApplicationController
  def index
    @insults = Insult.all
  end

  def new
    @insult = Insult.new
  end

  def edit
    @insult = Insult.find(params[:id])
  end

  def create
    @insult = Insult.new(insult_params)

    if @insult.save
      redirect_to insults_path, notice: I18n.t('insults.notice.create_successful')
    else
      render action: :new
    end
  end

  def update
    @insult = Insult.find(params[:id])

    if @insult.update(insult_params)
      redirect_to insults_path, notice: I18n.t('insults.notice.update_successful')
    else
      render action: :edit
    end
  end

  private

  def insult_params
    params.require(:insult).permit(:eating_what, :phrase)
  end
end
