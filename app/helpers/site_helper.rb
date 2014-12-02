module SiteHelper
  def pricing_link(package)
    "/enrollment/personal_information?package_type=#{package}"
  end

  def pretty_date(date)
    return unless date
    date.strftime('%b %e, %Y')
  end
end
