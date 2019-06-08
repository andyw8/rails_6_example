require "pages/support/wait_for_xhr"

module Sections
  class Item < SitePrism::Section
    include WaitForXhr

    def complete
      check label_text
      wait_for_xhr
    end

    def label_text
      find('label').text
    end
  end
end
