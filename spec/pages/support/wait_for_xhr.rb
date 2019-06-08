module WaitForXhr
  def self.included(base)
    base.class_eval do
      element :nprogress_busy, ".nprogress-busy"
    end
  end

  private

  def wait_for_xhr
    wait_until_nprogress_busy_invisible
  end
end
