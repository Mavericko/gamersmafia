%w(
    acts_as_categorizable
    acts_as_content
    acts_as_content_browser
    all
    cms
    bank
    gmstats
    skins
    ads
    stats
  ).each do |f|
  require "#{Rails.root}/lib/#{f}.rb"
end

Cms.uncompress_ckeditor_if_necessary
