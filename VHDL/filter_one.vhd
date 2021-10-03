----------------------------------------------------------------------------------
---                             Gaussian Filter
--- Reza Tanakizadeh
--- Bahman 1399
--- Description:
--- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity filter_one is
    --- define 
    generic(
        pixel_width : natural := 8
    );
    --- define all ports
    port(
        a00, a01, a02, a10, a11, a12, a20, a21, a22 : in signed(pixel_width-1 downto 0);
        result_one                                  : out signed(13 downto 0) := (others => '0');
        result_two                                  : out signed(13 downto 0) := (others => '0');
        result_three                                : out signed(13 downto 0) := (others => '0');
        result_four                                 : out signed(13 downto 0) := (others => '0')
    );
end filter_one;

architecture Behavioral of filter_one is
    --- Define signals for filter one
    signal W_cross_I_one    : signed(18 downto 0);
    
    constant f00_1      : signed(7 downto 0) := to_signed(-5, 8);
    constant f01_1      : signed(7 downto 0) := to_signed(-23, 8);
    constant f02_1      : signed(7 downto 0) := to_signed(-9, 8);

    constant f10_1      : signed(7 downto 0) := to_signed(3, 8);
    constant f11_1      : signed(7 downto 0) := to_signed(-27, 8);
    constant f12_1      : signed(7 downto 0) := to_signed(-43, 8);

    constant f20_1      : signed(7 downto 0) := to_signed(20, 8);
    constant f21_1      : signed(7 downto 0) := to_signed(41, 8);
    constant f22_1      : signed(7 downto 0) := to_signed(57, 8);

    constant b_one    : signed(7 downto 0) := to_signed(67, 8);



    --- Define signals for filter two
    signal W_cross_I_two    : signed(18 downto 0);
    
    constant f00_2      : signed(7 downto 0) := to_signed(22, 8);
    constant f01_2      : signed(7 downto 0) := to_signed(-17, 8);
    constant f02_2      : signed(7 downto 0) := to_signed(-7, 8);

    constant f10_2      : signed(7 downto 0) := to_signed(-8, 8);
    constant f11_2      : signed(7 downto 0) := to_signed(4, 8);
    constant f12_2      : signed(7 downto 0) := to_signed(-3, 8);

    constant f20_2      : signed(7 downto 0) := to_signed(-14, 8);
    constant f21_2      : signed(7 downto 0) := to_signed(12, 8);
    constant f22_2      : signed(7 downto 0) := to_signed(-17, 8);

    constant b_two    : signed(7 downto 0) := to_signed(-33, 8);



    --- Define signals for filter three
    signal W_cross_I_three    : signed(18 downto 0);
    
    constant f00_3      : signed(7 downto 0) := to_signed(-13, 8);
    constant f01_3      : signed(7 downto 0) := to_signed(-12, 8);
    constant f02_3      : signed(7 downto 0) := to_signed(10, 8);

    constant f10_3      : signed(7 downto 0) := to_signed(-11, 8);
    constant f11_3      : signed(7 downto 0) := to_signed(-3, 8);
    constant f12_3      : signed(7 downto 0) := to_signed(14, 8);

    constant f20_3      : signed(7 downto 0) := to_signed(-9, 8);
    constant f21_3      : signed(7 downto 0) := to_signed(-20, 8);
    constant f22_3      : signed(7 downto 0) := to_signed(-4, 8);

    constant b_three    : signed(7 downto 0) := to_signed(27, 8);



    --- Define signals for filter four
    signal W_cross_I_four    : signed(18 downto 0);
    
    constant f00_4      : signed(7 downto 0) := to_signed(39, 8);
    constant f01_4      : signed(7 downto 0) := to_signed(86, 8);
    constant f02_4      : signed(7 downto 0) := to_signed(20, 8);

    constant f10_4      : signed(7 downto 0) := to_signed(66, 8);
    constant f11_4      : signed(7 downto 0) := to_signed(82, 8);
    constant f12_4      : signed(7 downto 0) := to_signed(-20, 8);

    constant f20_4      : signed(7 downto 0) := to_signed(91, 8);
    constant f21_4      : signed(7 downto 0) := to_signed(13, 8);
    constant f22_4      : signed(7 downto 0) := to_signed(7, 8);

    constant b_four    : signed(7 downto 0) := to_signed(0, 8);
    
begin
    --- sum calc 
    W_cross_I_one    <= resize(f00_1 * a00, 19) + (f01_1 * a01) + (f02_1 * a02) + (f10_1 * a10) + (f11_1 * a11) + (f12_1 * a12) + (f20_1 * a20) + (f21_1 * a21) + (f22_1 * a22);
    W_cross_I_two    <= resize(f00_2 * a00, 19) + (f01_2 * a01) + (f02_2 * a02) + (f10_2 * a10) + (f11_2 * a11) + (f12_2 * a12) + (f20_2 * a20) + (f21_2 * a21) + (f22_2 * a22);
    W_cross_I_three  <= resize(f00_3 * a00, 19) + (f01_3 * a01) + (f02_3 * a02) + (f10_3 * a10) + (f11_3 * a11) + (f12_3 * a12) + (f20_3 * a20) + (f21_3 * a21) + (f22_3 * a22);
    W_cross_I_four   <= resize(f00_4 * a00, 19) + (f01_4 * a01) + (f02_4 * a02) + (f10_4 * a10) + (f11_4 * a11) + (f12_4 * a12) + (f20_4 * a20) + (f21_4 * a21) + (f22_4 * a22);

    --- make result
    result_one    <=  resize(W_cross_I_one(18 downto 6), 14) + b_one;
    result_two    <=  resize(W_cross_I_two(18 downto 6), 14) + b_two;
    result_three  <=  resize(W_cross_I_three(18 downto 6), 14) + b_three;
    result_four   <=  resize(W_cross_I_four(18 downto 6), 14) + b_four;

end Behavioral;

