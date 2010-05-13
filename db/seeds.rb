# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

HomophoneSet.delete_all
Homophone.delete_all
loader = HomophoneSetLoader.new
loader.load_from_file 'homlist.txt'
loader.save
