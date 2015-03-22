module CommonMethods

  def create_helper(object)
    respond_to do |format|
      if object.save
        format.html { redirect_to object, notice: "#{object.class.name} was successfully created." }
        format.json { render :show, status: :created, location: object }
      else
        format.html { render :new }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end
end