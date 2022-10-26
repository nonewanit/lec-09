class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.all
  end

  # GET /students/1 or /students/1.json
  def show
    must_be_logged_in
  end

  # GET /students/new
  def new
    must_be_logged_in
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    must_be_logged_in
  end

  # POST /students or /students.json
  def create
    must_be_logged_in
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    must_be_logged_in
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    must_be_logged_in
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit_score
    @student = Student.find(params[:id])
    sum = 0
    cnt = 0
    mx = -1
    @mxsub = ""
    for score in Score.where(student: @student)
      sum += score.point
      cnt+=1
      if score.point > mx
        mx = score.point
        @mxsub = score.subject
      end
    end
    @avg = sum/cnt
    @db = Score.where(student: @student)
    # i = 1
    # for data in @db
    #   if params["edit#{i}"]
    #     redirect_to action:"#{params[:id]}/edit", id: params[:id]
    #   elsif params["delete#{i}"]
    #     data.destroy
    #     data.save
    #     redirect_to action:"destroy"  
    #   end
    #   i+=1
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :dob, :student_no, :class_year)
    end
end
