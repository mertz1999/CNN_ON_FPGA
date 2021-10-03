----------------------------------------------------------------------------------
---                       Combining Conv together😎
--- Reza Tanakizadeh
--- Tir 1400
--- Description:
--- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity main_conv is
    generic(
        g_width : natural := 8;
        g_depth : integer := 10
    );
    port(
        --- Define Clock port
        clk : in std_logic;
        
        --- Define Data ports
        wr_data : in std_logic_vector(g_width-1 downto 0);
        wr_en   : in std_logic;

        --- Reset system
        i_rst_sync : in  std_logic := '0';

        --- Result port
        conv_en                                     : out std_logic := '0';
        result_one                                  : out signed(13 downto 0);
        result_two                                  : out signed(13 downto 0);
        result_three                                : out signed(13 downto 0);
        result_four                                 : out signed(13 downto 0)
    );
end main_conv;

architecture Behavioral of main_conv is
    --- Loading Three-FIFO component
    component three_FIFO
    generic(
        g_width : natural;
        g_depth : integer 
    );
    port(
        clk                                 : in std_logic;
        wr_data                             : in std_logic_vector(g_width-1 downto 0);
        wr_en                               : in std_logic;
        i_rst_sync                          : in  std_logic := '0';
        a00,a01,a02,a10,a11,a12,a20,a21,a22 : out std_logic_vector(g_width-1 downto 0)

    );
    END component;

    --- Loading Filter one Component
    component filter_one
    generic(
        pixel_width : natural
    );
    port(
        a00, a01, a02, a10, a11, a12, a20, a21, a22 : in signed(pixel_width-1 downto 0);
        result_one                                  : out signed(13 downto 0);
        result_two                                  : out signed(13 downto 0);
        result_three                                : out signed(13 downto 0);
        result_four                                 : out signed(13 downto 0)
    );
    END component;

    --- Loading  Relu component
    component Relu
    port(
        result_one   : in signed(13 downto 0);
        result_two   : in signed(13 downto 0);
        result_three : in signed(13 downto 0);
        result_four  : in signed(13 downto 0);
        relu_one     : out signed(13 downto 0);
        relu_two     : out signed(13 downto 0);
        relu_three   : out signed(13 downto 0);
        relu_four    : out signed(13 downto 0)
    );
    END component;

    --- Define Siganls
    signal a00,a01,a02,a10,a11,a12,a20,a21,a22  : std_logic_vector(g_width-1 downto 0);
    signal resultf_one                          : signed(13 downto 0);
    signal resultf_two                          : signed(13 downto 0);
    signal resultf_three                        : signed(13 downto 0);
    signal resultf_four                         : signed(13 downto 0);
    signal counter                              : integer range 1 to 19  := 1;

begin
    --- port map for three-FIFO
    threeFIFO : three_FIFO
    GENERIC MAP(g_width => g_width, g_depth => g_depth)
    PORT MAP(
        clk        => clk,
        wr_data    => wr_data,
        wr_en      => wr_en,
        i_rst_sync => i_rst_sync,
        a00        => a00,
        a01        => a01,
        a02        => a02,
        a10        => a10,
        a11        => a11,
        a12        => a12, 
        a20        => a20,
        a21        => a21,
        a22        => a22
    );
    --- port map for Filtering
    filter_one_main : filter_one
    GENERIC MAP(pixel_width => g_width)
    PORT MAP(
        result_one     => resultf_one,
        result_two     => resultf_two,
        result_three   => resultf_three,
        result_four    => resultf_four,
        a00            => signed(a00),
        a01            => signed(a01),
        a02            => signed(a02),
        a10            => signed(a10),
        a11            => signed(a11),
        a12            => signed(a12), 
        a20            => signed(a20),
        a21            => signed(a21),
        a22            => signed(a22) 
    );
    
    --- port map for Relu
    relu_func : Relu
    PORT MAP(
        result_one   => resultf_one,
        result_two   => resultf_two,
        result_three => resultf_three,
        result_four  => resultf_four,

        relu_one     => result_one,
        relu_two     => result_two,
        relu_three   => result_three,
        relu_four    => result_four
    );

    --- counter for bigining process
    counter_proc : process(clk, wr_en)
        begin
            if rising_edge(clk) and wr_en = '1' then
                if counter = 19 then
                    conv_en <= '1';
                else
                    counter <= counter + 1;
                end if;
            end if;
    end process;

end Behavioral;

