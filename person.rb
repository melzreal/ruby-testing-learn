require "rspec/autorun"

class Person
    attr_accessor :first_name, :middle_name, :last_name
    
    def initialize(first_name, middle_name = nil, last_name)
      @first_name = first_name
      @middle_name = middle_name
      @last_name = last_name
    end

    def full_name
       "#{@first_name}#{@middle_name} #{@last_name}"
    end

    def initials
        @middle_name ? "#{@first_name[0]}#{@middle_name[0]} #{@last_name[0]}" : 
        "#{@first_name[0]} #{@last_name[0]}"
    end

end

describe Person do

    describe "#full_name" do
      it "concatenates first name, middle name, and last name with spaces" do
        person = Person.new( "Maria", "Santos")
        expect(person.full_name).to include('Maria Santos')
      end
    end
  
    # describe "#full_name_with_middle_initial"
    #     it "returns the full name with"
    # end 
  
    describe "#initials" do
        it "retrieves just the first letters of each name" do
          person = Person.new( "Maria", "Santos")
          expect(person.initials).to include('M S')
        end
      end
  end