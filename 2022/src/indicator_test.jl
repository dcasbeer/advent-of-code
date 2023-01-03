using GLMakie

function indicator(ax::Axis,ob)
    register_interaction!(ax, :indicator) do event::MouseEvent, axis
    if event.type === MouseEventTypes.over
        ob[] = event.data
    end
    end
end
function indicator(grid::GridLayout,ob)
    foreach(Axis,grid;recursive=true) do ax
    indicator(ax,ob)
    end
end
function indicator(grid::GridLayout)
    ob = Observable(Point2f0(0.,0.))
    indicator(grid,ob)
    ob
end
function indicator(fig,args...; tellwidth=false, kwargs...)
    Label(
        fig,
        lift(ind->"x: $(ind[1])  y: $(ind[2])",indicator(fig.layout)),
        args...; tellwidth=tellwidth, kwargs...
    )
end
# function indicator!(sc::Scene,position=(0,0),size=1)
#     lims = sc.data_limits[]
#     midpoint = Point2f0((lims.origin + lims.widths/2)[1:2])
#     position_string = lift(sc.events.mouseposition) do mp
#         x,y = Point2f0(mp) |> x->to_world(sc,x) |> Tuple
#         "x: $(x)  y: $(y)"
#     end
#     display_position = lift(sc.events.mouseposition,sc.events.scroll;init=midpoint) do mp,scroll
#             position |> Point2f0 |> x->to_world(sc,x)
#     end
#     dsize = lift(sc.camera.projection) do pro
#         size/√(pro[1,1]^2+pro[2,1]^2)*5e-2
#     end
#     text!(sc,position_string,position=display_position,textsize=dsize)
# end

plot_range_1 = range(0,1;length=1000)
# plot_range_2 = range(0,100;length=1000)
fig = Figure()
ax1 = fig[1,1] = Axis(fig)
# ax2 = fig[1,2] = Axis(fig)
# lay2 = fig[1,3] = GridLayout()
# ax3 = lay2[1,1] = Axis(fig)
# ax4 = lay2[2,1] = Axis(fig)
l1 = lines!(ax1,plot_range_1,plot_range_1 .^ 2)
# l2 = lines!(ax2,plot_range_1,plot_range_1 .^ 3)
# l3 = lines!(ax3,plot_range_1,plot_range_1 .^ 4)
# l4 = lines!(ax4,plot_range_2, sqrt.(plot_range_2) .* sin.(plot_range_2))
txt= fig[2,:] = indicator(fig)
display(fig)