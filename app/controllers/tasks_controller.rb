class TasksController < ApplicationController
  def show
    @svgs = ["https://www.youtube.com/watch?v=jGKN1N5xqFg", "http://google.com"].map do |url|
      qrcode = RQRCode::QRCode.new(url)
      qrcode.as_svg(
        offset: 0,
        color: '000',
        shape_rendering: 'crispEdges',
        module_size: 6,
        standalone: true
      )
    end
  end
end