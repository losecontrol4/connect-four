Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file } #way to load everything in lib thanks to this stack overflow post https://stackoverflow.com/questions/735073/best-way-to-require-all-files-from-a-directory-in-ruby 


player1 = Player.new("a")
player2 = Player.new("c")
game = FourInARow.new(player1, player2)
game.play