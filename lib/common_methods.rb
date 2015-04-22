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

  def update_helper(object, params)
    respond_to do |format|
      if object.update(params)
        format.html { redirect_to object, notice: "#{object.class.name} was successfully updated." }
        format.json { render :show, status: :ok, location: object }
      else
        format.html { render :edit }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_helper(url, class_name)
    respond_to do |format|
      format.html { redirect_to url, notice: "#{class_name} was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def difference_in_months(date)
    ((Date.today - date)/30).to_f
  end

end