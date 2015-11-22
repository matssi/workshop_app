require 'prawn'

module CertificateGenerator

  ENV_PATH = ENV['RACK_ENV'] || 'development'

  def self.generate(certificate)
    details = {name: certificate.student.full_name,
               date: certificate.delivery.start_date.to_s,
               course_name: certificate.delivery.course.title,
               course_desc: certificate.delivery.course.description}
    output = "pdf/#{ENV_PATH}/#{details[:name]}-#{details[:date]}.pdf"
    image = File.absolute_path('./pdf/templates/certificate_tpl.jpg')
    url = "http://my_domain.com/verify/#{certificate.identifier}"
    File.delete(output) if File.exist?(output)
    Prawn::Document.generate(output,
                             page_size: 'A4',
                             background: image,
                             background_scale: 0.8231,
                             page_layout: :landscape,
                             left_margin: 30,
                             right_margin: 40,
                             top_margin: 7,
                             bottom_margin: 0,
                             skip_encoding: true) do |pdf|
      pdf.move_down 245
      pdf.font 'assets/fonts/Gotham-Bold.ttf'
      pdf.text details[:name], size: 44, color: '009900', align: :center
      pdf.move_down 20
      pdf.font 'assets/fonts/Gotham-Medium.ttf'
      pdf.text details[:course_name], indent_paragraphs: 150, size: 20
      pdf.text details[:course_desc], indent_paragraphs: 150, size: 20
      pdf.move_down 95
      pdf.text " #{details[:date]}", indent_paragraphs: 135, size: 12
      pdf.move_down 65
      pdf.text "To verify this certificate, visit: #{url}", indent_paragraphs: 100, size: 8
    end
  end

end