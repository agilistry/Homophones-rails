# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

HomophoneSet.delete_all
Homophone.delete_all
loader = HomophoneSetLoader.new
filepath = File.join(Rails.root, 'homlist.txt');
loader.load_from_file filepath
loader.save
