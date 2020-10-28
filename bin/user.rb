class Player
    attr_reader :name, :value
        def initialize(name,value)
        @name = name
        @value = value
        end


        def show_players_info
        puts name,value
        end
end

