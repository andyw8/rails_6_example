module Pages
  class Lists < SitePrism::Page

    set_url "/lists"
    elements :lists, "ul li"

    def list_titles
      lists.map(&:text)
    end
  end
end
