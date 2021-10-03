----------------------------------------------------------------------------------
---                  Conv layer + Activaion + max-pooling
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.cnn_types.all;

entity main_feature is
    port(
        --- Input ports
        clk        : in std_logic;
        wr_data    : in std_logic_vector(7 downto 0);
        wr_en      : in std_logic := '0';
        i_rst_sync : in std_logic := '0';

        --- Output ports
        feature_result_one   : out signed(13 downto 0);
        feature_result_two   : out signed(13 downto 0);
        feature_result_three : out signed(13 downto 0);
        feature_result_four  : out signed(13 downto 0);
        feature_result_en    : out state                 

    );
end main_feature;

architecture Behavioral of main_feature is
    --- Component for conv layer + Activation
    component main_conv
        port(
            clk          : in  std_logic;
            wr_data      : in  std_logic_vector(7 downto 0);
            wr_en        : in  std_logic;
            i_rst_sync   : in  std_logic := '0';
            conv_en      : out std_logic := '0';
            result_one   : out signed(13 downto 0);
            result_two   : out signed(13 downto 0);
            result_three : out signed(13 downto 0);
            result_four  : out signed(13 downto 0)
        );
    end component;

    --- Component for max-pooling layer
    component max_pooling
        port(
            clk          : in std_logic;
            pool_en      : in std_logic := '0';
            result_one   : in signed(13 downto 0);
            result_two   : in signed(13 downto 0);
            result_three : in signed(13 downto 0);
            result_four  : in signed(13 downto 0);            
            pooling_result_one   : out signed(13 downto 0);
            pooling_result_two   : out signed(13 downto 0);
            pooling_result_three : out signed(13 downto 0);
            pooling_result_four  : out signed(13 downto 0);
            pooling_result_en : out state
        );
    end component;

    --- Define signals
    signal conv_en      : std_logic := '0';
    signal result_one   : signed(13 downto 0);
    signal result_two   : signed(13 downto 0);
    signal result_three : signed(13 downto 0);
    signal result_four  : signed(13 downto 0);

begin

--- Instance of main_conv component
conv_activation : main_conv port map(
    clk          => clk,
    wr_data      => wr_data,
    wr_en        => wr_en,
    i_rst_sync   => i_rst_sync,
    conv_en      => conv_en,
    result_one   => result_one,
    result_two   => result_two,
    result_three => result_three,
    result_four  => result_four
);

--- Instance of max_pooling component
max_pooling_layer : max_pooling port map(
    clk                  => clk,
    pool_en              => conv_en,
    result_one           => result_one,
    result_two           => result_two,
    result_three         => result_three,
    result_four          => result_four,
    pooling_result_one   => feature_result_one,
    pooling_result_two   => feature_result_two,
    pooling_result_three => feature_result_three,
    pooling_result_four  => feature_result_four,
    pooling_result_en    => feature_result_en
);
end Behavioral;

