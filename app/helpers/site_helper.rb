module SiteHelper
  def pricing_link(package)
    "/enrollment/personal_information?package_type=#{package}"
  end
end
