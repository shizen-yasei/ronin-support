require 'spec_helper'
require 'ronin/formatting/binary'

require 'ostruct'

describe Integer do
  subject { 0x41 }

  it "should provide Integer#bytes" do
    should respond_to(:bytes)
  end

  it "should provide Integer#pack" do
    should respond_to(:pack)
  end

  it "should provide Integer#hex_escape" do
    should respond_to(:hex_escape)
  end

  it "should alias char to the #chr method" do
    subject.char.should == subject.chr
  end

  describe "#hex_escape" do
    subject { 42 }

    it "should hex escape an Integer" do
      subject.hex_escape.should == "\\x2a"
    end
  end

  describe "#bytes" do
    let(:little_endian_char)  { [0x37] }
    let(:little_endian_short) { [0x37, 0x13] }
    let(:little_endian_long)  { [0x37, 0x13, 0x0, 0x0] }
    let(:little_endian_quad)  { [0x37, 0x13, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0] }

    let(:big_endian_char)  { [0x37] }
    let(:big_endian_short) { [0x13, 0x37] }
    let(:big_endian_long)  { [0, 0, 0x13, 0x37] }
    let(:big_endian_quad)  { [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x13, 0x37] }

    subject { 0x1337 }

    it "should return the bytes in little endian ordering by default" do
      subject.bytes(4).should == little_endian_long
    end

    it "should return the bytes for a char in little endian ordering" do
      subject.bytes(1, :little).should == little_endian_char
    end

    it "should return the bytes for a short in little endian ordering" do
      subject.bytes(2, :little).should == little_endian_short
    end

    it "should return the bytes for a long in little endian ordering" do
      subject.bytes(4, :little).should == little_endian_long
    end

    it "should return the bytes for a quad in little endian ordering" do
      subject.bytes(8, :little).should == little_endian_quad
    end

    it "should return the bytes for a char in big endian ordering" do
      subject.bytes(1, :big).should == big_endian_char
    end

    it "should return the bytes for a short in big endian ordering" do
      subject.bytes(2, :big).should == big_endian_short
    end

    it "should return the bytes for a long in big endian ordering" do
      subject.bytes(4, :big).should == big_endian_long
    end

    it "should return the bytes for a quad in big endian ordering" do
      subject.bytes(8, :big).should == big_endian_quad
    end
  end

  describe "#pack" do
    let(:i386) do
      OpenStruct.new(:endian => :little, :address_length => 4)
    end

    let(:ppc) do
      OpenStruct.new(:endian => :big, :address_length => 4)
    end

    subject { 0x1337 }

    let(:i386_packed_int)   { "7\023\000\000" }
    let(:i386_packed_short) { "7\023" }
    let(:i386_packed_long)  { "7\023\000\000" }
    let(:i386_packed_quad)  { "7\023\000\000\000\000\000\000" }

    let(:ppc_packed_int)   { "\000\000\0237" }
    let(:ppc_packed_short) { "\0237" }
    let(:ppc_packed_long)  { "\000\000\0237" }
    let(:ppc_packed_quad)  { "\000\000\000\000\000\000\0237" }

    it "should pack itself for a little-endian architecture by default" do
      subject.pack(i386).should == i386_packed_int
    end

    it "should pack itself as a short for a little-endian architecture" do
      subject.pack(i386,2).should == i386_packed_short
    end

    it "should pack itself as a long for a little-endian architecture" do
      subject.pack(i386,4).should == i386_packed_long
    end

    it "should pack itself as a quad for a little-endian architecture" do
      subject.pack(i386,8).should == i386_packed_quad
    end

    it "should pack itself for a big-endian architecture" do
      subject.pack(ppc).should == ppc_packed_int
    end

    it "should pack itself as a short for a big-endian architecture" do
      subject.pack(ppc,2).should == ppc_packed_short
    end

    it "should pack itself as a long for a big-endian architecture" do
      subject.pack(ppc,4).should == ppc_packed_long
    end

    it "should pack itself as a quad for a big-endian architecture" do
      subject.pack(ppc,8).should == ppc_packed_quad
    end

    it "should accept Array#pack template strings" do
      subject.pack('L').should == i386_packed_long
    end
  end
end
