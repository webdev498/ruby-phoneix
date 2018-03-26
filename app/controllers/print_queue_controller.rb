class PrintQueueController < ApplicationController

# NOTE:
# THIS IS THE STRIPPED DOWN VERSION OF THE P_Q_CONTROLLER
#

  before_action :set_print_queue, only: [:contents, :rxLabel]


  def contents
  # TESTING:
    render json: { "contents": [ {"label": "labelFile001.pdf"}, {"label": "labelFile002.pdf"} ]}
  end

  def getRxLabel
    # render text: 'rxLabel'
  end


  # all print material is in the
  def getNextPrint

    if params[:pwd] == "phx4SEGH10"    # hardcoded during testing ...
      print_file_path = File.join(Rails.root, "phx_print_queue_files")
      print_file_cache = File.join(Rails.root, "phx_print_queue_files/cache")
      pdf_files = Dir.glob("#{print_file_path}/*.pdf")
      if !pdf_files.empty?
        target_pdf = File.join( print_file_cache, File.basename( pdf_files.first ))
        File.rename pdf_files.first, target_pdf
        # send_file ( pdf_files.first )
        send_file target_pdf, type: 'application/pdf', disposition: 'attachment', filename: (File.basename target_pdf)
      else
        head :no_content
      end
    else
      # send_file ( 'label_print_error.pdf')
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_queue
#      @print_qelsueue = PrintQueue.find(params[:rxno])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_queue_params
      params.require(:print_queue).permit(:rxno)
    end

end
