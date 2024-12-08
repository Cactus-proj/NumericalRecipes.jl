using NumericalRecipes
using Documenter

DocMeta.setdocmeta!(NumericalRecipes, :DocTestSetup, :(using NumericalRecipes); recursive=true)

makedocs(;
    modules=[NumericalRecipes],
    authors="Chengyu HAN <cyhan.dev@outlook.com> and contributors",
    sitename="NumericalRecipes.jl",
    format=Documenter.HTML(;
        canonical="https://cactus-proj.github.io/NumericalRecipes.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
    checkdocs=:exports,
)

deploydocs(;
    repo="github.com/Cactus-proj/NumericalRecipes.jl",
    devbranch="main",
)
