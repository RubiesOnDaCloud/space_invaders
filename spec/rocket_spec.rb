RSpec.describe SpaceInvaders::Rocket do

  describe "#move_left" do
    it "moves the rocket left by 10 pixel" do
      rocket = SpaceInvaders::Rocket.new(15, 0, 0, 500)
      expect(rocket.x).to be(15)
      rocket.move_left
      expect(rocket.x).to be(5)
    end
    it "stops at the left edge" do
      rocket = SpaceInvaders::Rocket.new(9, 0, 0, 500)
      expect(rocket.x).to be(9)
      rocket.move_left
      expect(rocket.x).to be(0)
    end  
  end
  describe "#move_right" do
    it "moves the rocket right by 10 pixel" do
      rocket = SpaceInvaders::Rocket.new(200, 0, 0, 500)
      expect(rocket.x).to be(200)
      rocket.move_right
      expect(rocket.x).to be(210)
    end
    it "stops at the right edge" do
      rocket = SpaceInvaders::Rocket.new(435, 0, 0, 500)
      expect(rocket.x).to be(435)
      rocket.move_right
      expect(rocket.x).to be(444)
    end
  end
end
