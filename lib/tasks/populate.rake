# coding: utf-8

require 'csv'
require 'faker'
require 'populator'


namespace :data do

  task :taxonomies => :environment do
    Taxonomy.delete_all
    Taxonomy.populate 5 do |taxonomy|
      taxonomy.title = Faker::Lorem.words(1)[0].capitalize
    end

    puts "\nTaxonomies created!"

  end

  task :nested_taxons => :environment do

    Taxon.delete_all

    # instead of Taxon.reset_pk_sequence!
    # ActiveRecord::Base.connection.reset_pk_sequence!('taxons')

    Taxon.populate 10 do |taxon|
      taxon.title = Faker::Lorem.words(1)[0].capitalize
      taxon.taxonomy_id = Taxonomy.pluck(:id).sample
      taxon.seo_url = Faker::Lorem.words(1)[0]
      print '.'
    end

    puts '+'
    Taxon.rebuild!


    4.times do | |
      root = Taxon.roots.shuffle.first

      5.times do
        taxon = Taxon.new
        taxon.title = Faker::Lorem.words(1)[0].capitalize
        taxon.taxonomy_id = Taxonomy.pluck(:id).sample
        taxon.seo_url = Faker::Lorem.words(1)[0]
        taxon.save!
        print '.'
        taxon.move_to_child_of root
      end
    end

    puts '++'
    Taxon.rebuild!
    puts "\nNested taxons created!"

  end


  task :special_taxons => :environment do

    Taxon.where(taxon_type: [1,2]).destroy_all

    10.times do
      taxon = Taxon.new

      taxon.taxonomy_id = Taxonomy.first.id
      taxon.title = Faker::Lorem.words(1)[0].capitalize
      taxon.seo_url = Faker::Lorem.words(1)[0]
      taxon.taxon_type = 'by_care_type'

      taxon.save!
      print '.'
    end

    puts ''

    6.times do
      taxon = Taxon.new

      taxon.taxonomy_id = Taxonomy.first.id
      taxon.title = Faker::Lorem.words(1)[0].capitalize
      taxon.seo_url = Faker::Lorem.words(1)[0]
      taxon.taxon_type = 'by_age'

      taxon.save!
      print '.'
    end

    puts "\nSpecial taxons created!"
  end


  task fake_price_to_products: :environment do
    Product.all.each do |product|
      product.price = rand(990..9999)
      product.new_price = rand(600..5000)
      product.save!
      print '.'
    end
    puts "\ncompleted"
  end
  
  task admin_and_user: :environment do
    Admin.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
    User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    puts 'Done!'
  end
  

end