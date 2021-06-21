use Mix.Config

config :etsala, :ore,
  ubiquitous: %{
    types: [
      %{
        id: 46281,
        name: "Glistening Zeolites",
        industry: [%{id: 35, units: 16000}, %{id: 36, units: 800}, %{id: 16634, units: 130}]
      },
      %{
        id: 46286,
        name: "Brimful Coesite",
        industry: [%{id: 35, units: 2300}, %{id: 36, units: 460}, %{id: 16636, units: 75}]
      },
      %{
        id: 46282,
        name: "Brimful Sylvite",
        industry: [%{id: 35, units: 4600}, %{id: 36, units: 460}, %{id: 16635, units: 75}]
      },
      %{
        id: 46287,
        name: "Glistening Coesite",
        industry: [%{id: 35, units: 4000}, %{id: 36, units: 800}, %{id: 16636, units: 130}]
      },
      %{
        id: 46284,
        name: "Brimful Bitumens",
        industry: [%{id: 35, units: 6900}, %{id: 36, units: 460}, %{id: 16633, units: 75}]
      },
      %{
        id: 46280,
        name: "Brimful Zeolites",
        industry: [%{id: 35, units: 9200}, %{id: 36, units: 460}, %{id: 16634, units: 75}]
      },
      %{
        id: 46285,
        name: "Glistening Bitumens",
        industry: [%{id: 35, units: 12000}, %{id: 36, units: 800}, %{id: 16633, units: 130}]
      },
      %{
        id: 46283,
        name: "Glistening Sylvite",
        industry: [%{id: 35, units: 8000}, %{id: 36, units: 800}, %{id: 16635, units: 130}]
      },
      %{
        id: 45490,
        name: "Zeolites",
        industry: [%{id: 35, units: 8000}, %{id: 36, units: 400}, %{id: 16634, units: 65}]
      },
      %{
        id: 45491,
        name: "Sylvite",
        industry: [%{id: 35, units: 4000}, %{id: 36, units: 400}, %{id: 16635, units: 65}]
      },
      %{
        id: 45492,
        name: "Bitumens",
        industry: [%{id: 35, units: 6000}, %{id: 36, units: 400}, %{id: 16633, units: 65}]
      },
      %{
        id: 45493,
        name: "Coesite",
        industry: [%{id: 35, units: 2000}, %{id: 36, units: 400}, %{id: 16636, units: 65}]
      }
    ],
    materials: [
      %{id: 35, name: "Pyerite"},
      %{id: 36, name: "Mexallon"},
      %{id: 16633, name: "Hydrocarbons"},
      %{id: 16634, name: "Atmospheric Gases"},
      %{id: 16635, name: "Evaporite Deposits"},
      %{id: 16636, name: "Silicates"}
    ]
  },
  common: %{
    types: [
      %{id: 45494, name: "Cobaltite", industry: [%{id: 16640, units: 40}]},
      %{id: 46288, name: "Copious Cobaltite", industry: [%{id: 16640, units: 46}]},
      %{id: 46289, name: "Twinkling Cobaltite", industry: [%{id: 16640, units: 80}]},
      %{id: 45495, name: "Euxenite", industry: [%{id: 16639, units: 40}]},
      %{id: 46290, name: "Copious Euxenite", industry: [%{id: 16639, units: 46}]},
      %{id: 46291, name: "Twinkling Euxenite", industry: [%{id: 16639, units: 80}]},
      %{id: 45497, name: "Scheelite", industry: [%{id: 16637, units: 40}]},
      %{id: 46294, name: "Copious Scheelite", industry: [%{id: 16637, units: 46}]},
      %{id: 46295, name: "Twinkling Scheelite", industry: [%{id: 16637, units: 80}]},
      %{id: 45496, name: "Titanite", industry: [%{id: 16638, units: 40}]},
      %{id: 46292, name: "Copious Titanite", industry: [%{id: 16638, units: 46}]},
      %{id: 46293, name: "Twinkling Titanite", industry: [%{id: 16638, units: 80}]}
    ],
    materials: [
      %{id: 16640, name: "Cobalt"},
      %{id: 16639, name: "Scandium"},
      %{id: 16637, name: "Tungsten"},
      %{id: 16638, name: "Titanium"}
    ]
  },
  uncommon: %{
    types: [
      %{
        id: 45501,
        name: "Chromite",
        industry: [%{id: 16641, units: 40}, %{id: 16633, units: 10}]
      },
      %{
        id: 46302,
        name: "Lavish Chromite",
        industry: [%{id: 16641, units: 46}, %{id: 16633, units: 12}]
      },
      %{
        id: 46303,
        name: "Shimmering Chromite",
        industry: [%{id: 16641, units: 80}, %{id: 16633, units: 20}]
      },
      %{
        id: 45498,
        name: "Otavite",
        industry: [%{id: 16643, units: 40}, %{id: 16634, units: 10}]
      },
      %{
        id: 46296,
        name: "Lavish Otavite",
        industry: [%{id: 16643, units: 46}, %{id: 16634, units: 12}]
      },
      %{
        id: 46297,
        name: "Shimmering Otavite",
        industry: [%{id: 16643, units: 80}, %{id: 16634, units: 20}]
      },
      %{
        id: 45499,
        name: "Sperrylite",
        industry: [%{id: 16644, units: 40}, %{id: 16635, units: 10}]
      },
      %{
        id: 46298,
        name: "Lavish Sperrylite",
        industry: [%{id: 16644, units: 46}, %{id: 16635, units: 12}]
      },
      %{
        id: 46299,
        name: "Shimmering Sperrylite",
        industry: [%{id: 16644, units: 80}, %{id: 16635, units: 20}]
      },
      %{
        id: 45500,
        name: "Vanadinite",
        industry: [%{id: 16642, units: 40}, %{id: 16636, units: 10}]
      },
      %{
        id: 46300,
        name: "Lavish Vanadinite",
        industry: [%{id: 16642, units: 46}, %{id: 16636, units: 12}]
      },
      %{
        id: 46301,
        name: "Shimmering Vanadinite",
        industry: [%{id: 16642, units: 80}, %{id: 16636, units: 20}]
      }
    ],
    materials: [
      %{id: 16641, name: "Chromium"},
      %{id: 16643, name: "Cadmium"},
      %{id: 16644, name: "Platinum"},
      %{id: 16642, name: "Vanadium"},
      %{id: 16633, name: "Hydrocarbons"},
      %{id: 16634, name: "Atmospheric Gases"},
      %{id: 16635, name: "Evaporite Deposits"},
      %{id: 16636, name: "Silicates"}
    ]
  },
  rare: %{
    types: [
      %{
        id: 45502,
        name: "Carnotite",
        industry: [%{id: 16649, units: 50}, %{id: 16640, units: 10}, %{id: 16634, units: 15}]
      },
      %{
        id: 45502,
        name: "Replete Carnotite",
        industry: [%{id: 16649, units: 58}, %{id: 16640, units: 12}, %{id: 16634, units: 17}]
      },
      %{
        id: 45502,
        name: "Glowing Carnotite",
        industry: [%{id: 16649, units: 100}, %{id: 16640, units: 20}, %{id: 16634, units: 30}]
      },
      %{
        id: 45506,
        name: "Cinnabar",
        industry: [%{id: 16646, units: 50}, %{id: 16637, units: 10}, %{id: 16635, units: 15}]
      },
      %{
        id: 46310,
        name: "Replete Cinnabar",
        industry: [%{id: 16646, units: 58}, %{id: 16637, units: 12}, %{id: 16635, units: 17}]
      },
      %{
        id: 46311,
        name: "Glowing Cinnabar",
        industry: [%{id: 16646, units: 100}, %{id: 16637, units: 20}, %{id: 16635, units: 30}]
      },
      %{
        id: 45504,
        name: "Pollucite",
        industry: [%{id: 16647, units: 50}, %{id: 16639, units: 10}, %{id: 16633, units: 15}]
      },
      %{
        id: 46308,
        name: "Replete Pollucite",
        industry: [%{id: 16647, units: 58}, %{id: 16639, units: 12}, %{id: 16633, units: 17}]
      },
      %{
        id: 46309,
        name: "Glowing Pollucite",
        industry: [%{id: 16647, units: 100}, %{id: 16639, units: 20}, %{id: 16633, units: 30}]
      },
      %{
        id: 45503,
        name: "Zircon",
        industry: [%{id: 16648, units: 50}, %{id: 16638, units: 10}, %{id: 16636, units: 15}]
      },
      %{
        id: 46306,
        name: "Replete Zircon",
        industry: [%{id: 16648, units: 58}, %{id: 16638, units: 12}, %{id: 16636, units: 17}]
      },
      %{
        id: 46307,
        name: "Glowing Zircon",
        industry: [%{id: 16648, units: 100}, %{id: 16638, units: 20}, %{id: 16636, units: 30}]
      }
    ],
    materials: [
      %{id: 16649, name: "Technetium"},
      %{id: 16646, name: "Mercury"},
      %{id: 16647, name: "Caesium"},
      %{id: 16648, name: "Hafnium"},
      %{id: 16640, name: "Cobalt"},
      %{id: 16639, name: "Scandium"},
      %{id: 16637, name: "Tungsten"},
      %{id: 16638, name: "Titanium"},
      %{id: 16633, name: "Hydrocarbons"},
      %{id: 16634, name: "Atmospheric Gases"},
      %{id: 16635, name: "Evaporite Deposits"},
      %{id: 16636, name: "Silicates"}
    ]
  },
  exceptional: %{
    types: [
      %{
        id: 45512,
        name: "Loparite",
        industry: [
          %{id: 16652, units: 22},
          %{id: 16644, units: 10},
          %{id: 16639, units: 20},
          %{id: 16633, units: 20}
        ]
      },
      %{
        id: 46316,
        name: "Bountiful Loparite",
        industry: [
          %{id: 16652, units: 25},
          %{id: 16644, units: 12},
          %{id: 16639, units: 23},
          %{id: 16633, units: 23}
        ]
      },
      %{
        id: 46317,
        name: "Shining Loparite",
        industry: [
          %{id: 16652, units: 44},
          %{id: 16644, units: 20},
          %{id: 16639, units: 40},
          %{id: 16633, units: 40}
        ]
      },
      %{
        id: 45512,
        name: "Monazite",
        industry: [
          %{id: 16651, units: 22},
          %{id: 16641, units: 10},
          %{id: 16637, units: 20},
          %{id: 16633, units: 20}
        ]
      },
      %{
        id: 46316,
        name: "Bountiful Monazite",
        industry: [
          %{id: 16651, units: 25},
          %{id: 16641, units: 12},
          %{id: 16637, units: 23},
          %{id: 16633, units: 23}
        ]
      },
      %{
        id: 46317,
        name: "Shining Monazite",
        industry: [
          %{id: 16651, units: 44},
          %{id: 16641, units: 20},
          %{id: 16637, units: 40},
          %{id: 16633, units: 40}
        ]
      },
      %{
        id: 45510,
        name: "Xenotime",
        industry: [
          %{id: 16650, units: 22},
          %{id: 16642, units: 10},
          %{id: 16640, units: 20},
          %{id: 16634, units: 20}
        ]
      },
      %{
        id: 46312,
        name: "Bountiful Xenotime",
        industry: [
          %{id: 16650, units: 25},
          %{id: 16642, units: 12},
          %{id: 16640, units: 23},
          %{id: 16634, units: 23}
        ]
      },
      %{
        id: 46313,
        name: "Shining Xenotime",
        industry: [
          %{id: 16650, units: 44},
          %{id: 16642, units: 20},
          %{id: 16640, units: 40},
          %{id: 16634, units: 40}
        ]
      },
      %{
        id: 45510,
        name: "Ytterbite",
        industry: [
          %{id: 16653, units: 22},
          %{id: 16643, units: 10},
          %{id: 16640, units: 20},
          %{id: 16636, units: 20}
        ]
      },
      %{
        id: 46312,
        name: "Bountiful Ytterbite",
        industry: [
          %{id: 16653, units: 25},
          %{id: 16643, units: 12},
          %{id: 16640, units: 23},
          %{id: 16636, units: 23}
        ]
      },
      %{
        id: 46313,
        name: "Shining Ytterbite",
        industry: [
          %{id: 16653, units: 44},
          %{id: 16643, units: 20},
          %{id: 16640, units: 40},
          %{id: 16636, units: 40}
        ]
      }
    ],
    materials: [
      %{id: 16652, name: "Promethium"},
      %{id: 16651, name: "Neodymium"},
      %{id: 16650, name: "Dysprosium"},
      %{id: 16653, name: "Thulium"},
      %{id: 16641, name: "Chromium"},
      %{id: 16643, name: "Cadmium"},
      %{id: 16644, name: "Platinum"},
      %{id: 16642, name: "Vanadium"},
      %{id: 16640, name: "Cobalt"},
      %{id: 16639, name: "Scandium"},
      %{id: 16637, name: "Tungsten"},
      %{id: 16638, name: "Titanium"},
      %{id: 16633, name: "Hydrocarbons"},
      %{id: 16634, name: "Atmospheric Gases"},
      %{id: 16635, name: "Evaporite Deposits"},
      %{id: 16636, name: "Silicates"}
    ]
  }
