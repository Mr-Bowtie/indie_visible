task process_image_variants: :environment do
  books = Book.with_attached_cover_image.joins(:cover_image_attachment)
  authors = User.with_attached_photo.joins(:photo_attachment)
  promos = Promo.with_attached_banner.joins(:banner_attachment)
  businesses = Business.with_attached_logo_image.joins(:logo_image_attachment)

  books.each do |book|
    book.cover_image.variant(resize_to_limit: [250, 250]).processed
    book.cover_image.variant(resize_to_limit: [500, 500]).processed
  end

  authors.each do |author|
    author.photo.variant(resize_to_limit: [200, 200]).processed
    author.photo.variant(resize_to_limit: [500, 500]).processed
  end

  promos.each do |promo|
    promo.banner.variant(resize_to_limit: [1500, 400]).processed
  end

  businesses.each do |biz|
    biz.logo_image.variant(resize_to_limit: [400, 400]).processed
  end
end
