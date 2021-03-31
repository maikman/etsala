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
  }
