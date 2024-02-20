using NumericalRecipes
using Documenter

DocMeta.setdocmeta!(NumericalRecipes, :DocTestSetup, :(using NumericalRecipes); recursive=true)

makedocs(;
    modules=[NumericalRecipes],
    authors="woclass <git@wo-class.cn> and contributors",
    sitename="NumericalRecipes.jl",
    format=Documenter.HTML(;
        canonical="https://inkydragon.github.io/NumericalRecipes.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/inkydragon/NumericalRecipes.jl",
    devbranch="main",
)
