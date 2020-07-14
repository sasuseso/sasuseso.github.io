using Dates
function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits = 2)
end

function hfun_m1fill(vname)
    var = vname[1]
    println("typeof var: $(typeof(var))")
    return pagevar("blog/content2", var)
end

function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
end

function hfun_recentblogposts()
    list = readdir("blog")
    filter!(f -> endswith(f, ".md"), list)
    dates = [stat(joinpath("blog", f)).mtime for f in list]
    perm = sortperm(dates, rev = true)
    idxs = perm[1:min(3, length(perm))]
    io = IOBuffer()
    write(io, "\n")

    write(io, "<ul style=\"list-style : none;\">\n")
    for (k, i) in enumerate(idxs)
        fi = "blog/" * splitext(list[i])[1] * "/"
        @show fi
        write(
            io,
            """<li>
            <a href="$fi">$(pagevar(fi[begin:end-1], "title"))</a>
            $(Dates.format(Dates.unix2datetime(stat(joinpath("blog", list[i])).mtime), "yyyy-mm-dd"))
            $(let; str=""; for t in hfun_gettags(fi);str * t;end;str end)
            <div>$((pagevar(fi[begin:end-1], "desc") != nothing) ? pagevar(fi[begin:end-1], "desc") : "")</div>
            </li>\n""",
        )
    end
    write(io, "</ul>\n")
    write(io, "\n")
    return String(take!(io))
end

function hfun_gettags(fi)
    tags = pagevar(fi[begin:(end - 1)], "tags")
    if tags != nothing
        length(tags) == 0 ? "" : split(tags, ",")
    else
        ""
    end
end
