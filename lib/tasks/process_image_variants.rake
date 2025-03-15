task process_image_variants: :environment do
  books = Book.with_attached_cover_image.joins(:cover_image_attachment)
  authors = User.with_attached_photo.joins(:photo_attachment)
  promos = Promo.with_attached_banner.joins(:banner_attachment)
  businesses = Business.with_attached_logo_image.joins(:logo_image_attachment)

  coverless_books = []
  books.each do |book|
    book.cover_image.variant(resize_to_limit: [250, 250]).processed
    book.cover_image.variant(resize_to_limit: [500, 500]).processed
  rescue ActiveStorage::FileNotFoundError
    coverless_books.push(book.title)
  end

  photoless_authors = []
  authors.each do |author|
    author.photo.variant(resize_to_limit: [200, 200]).processed
    author.photo.variant(resize_to_limit: [500, 500]).processed
  rescue ActiveStorage::FileNotFoundError
    photoless_authors.push(author.name)
  end

  bannerless_promos = []
  promos.each do |promo|
    promo.banner.variant(resize_to_limit: [1500, 400]).processed
  rescue ActiveStorage::FileNotFoundError
    bannerless_promos.push(promo.title)
  end

  logoless_businesses = []
  businesses.each do |biz|
    biz.logo_image.variant(resize_to_limit: [400, 400]).processed
  rescue ActiveStorage::FileNotFoundError
    logoless_businesses.push(biz.name)
  end

  puts 'Books without a cover:' unless coverless_books.empty?
  coverless_books.each { |title| puts "- #{title}" }

  puts 'Authors without a photo' unless photoless_authors.empty?
  photoless_authors.each { |author| puts "- #{author}" }

  puts 'Promos without a banner' unless bannerless_promos.empty?
  bannerless_promos.each { |promo| puts "- #{promo}" }

  puts 'Businesses without a logo' unless logoless_businesses.empty?
  logoless_businesses.each { |biz| puts "- #{biz}" }
end
