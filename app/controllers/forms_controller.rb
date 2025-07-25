class FormsController < ApplicationController
  before_action :set_form, except: %i[ index new create ]

  # GET /forms or /forms.json
  def index
    @forms = current_user.forms
    @token = User.encrypt_id(current_user.id)
  end

  # GET /forms/1 or /forms/1.json
  def show
    @form_url = request.base_url + api_v1_form_data_entries_path(@form)
    @data_entries = @form.data_entries
    @payloads = @data_entries.pluck(:payload).map { |p| JSON.parse(p) }
  end

  # GET /forms/new
  def new
    @form = Form.new
  end

  # GET /forms/1/edit
  def edit
  end

  # POST /forms or /forms.json
  def create
    @form = current_user.forms.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: "Form was successfully created." }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forms/1 or /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to @form, notice: "Form was successfully updated." }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /forms/1/download_csv
  def download_csv
    csv_data = @form.data_entries_to_csv
    send_data csv_data, filename: "form_#{@form.id}_data_entries.csv", type: 'text/csv'
  end

  def download_excel
    excel_data = @form.data_entries_to_excel
    send_data excel_data, filename: "form_#{@form.id}_data_entries.xlsx", type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  end

  # GET /forms/1/download_json
  def download_json
    json_data = @form.data_entries_to_json
    send_data json_data, filename: "form_#{@form.id}_data_entries.json", type: 'application/json'
  end

  # DELETE /forms/1 or /forms/1.json
  def destroy
    @form.destroy!

    respond_to do |format|
      format.html { redirect_to forms_path, status: :see_other, notice: "Form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def form_params
      params.expect(form: [ :name, :website_id ])
    end
end
