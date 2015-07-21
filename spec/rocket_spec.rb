RSpec.describe SpaceInvaders::Rocket do
  describe "#move_left" do
    it "moves the rocket left by 10 pixel" do
      rocket = SpaceInvaders::Rocket.new(0, 0, 0)
      expect(rocket.x).to be(0)
      rocket.move_left
      expect(rocket.x).to be(-10)
    end
  end
  describe "#move_right" do
    it "moves the rocket right by 10 pixel" do
      rocket = SpaceInvaders::Rocket.new(0, 0, 0)
      expect(rocket.x).to be(0)
      rocket.move_right
      expect(rocket.x).to be(10)
    end
  end
end
