namespace :compositions do
  task reprocess_32: :environment do
    Composition.find(32).img.reprocess!
  end
  
  task reprocess_all: :environment do
    Composition.availible.find_each{|s| s.img.reprocess!}
  end
end