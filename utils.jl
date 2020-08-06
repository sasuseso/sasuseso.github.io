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
        title = pagevar(fi[begin:(end - 1)], "title")
        write(
            io,
            """<li>
            <a href="$fi">"$(title == nothing ? "" : title)"</a>
            $(Dates.format(Dates.unix2datetime(stat(joinpath("blog", list[i])).mtime), "yyyy-mm-dd"))
            <div>$((pagevar(fi[begin:end-1], "desc") != nothing) ? pagevar(fi[begin:end-1], "desc") : "")</div>
            </li>\n""",
        )
    end
    write(io, "</ul>\n")
    write(io, "\n")
    return String(take!(io))
end

function hfun_getalltags()
    list = readdir("blog")
    filter!(f -> endswith(f, ".md"), list)
    dates = [stat(joinpath("blog", f)).mtime for f in list]
    perm = sortperm(dates, rev = true)
    idxs = perm[1:min(3, length(perm))]
    io = IOBuffer()
    write(io, "\n")

    tags_count = Dict{String,Int}()
    for (k, i) in enumerate(idxs)
        fi = "blog/" * splitext(list[i])[1]
        tags = pagevar(fi, "tags")


        for t in tags
            if haskey(tags_count, t)
                tags_count[t] += 1
            else
                push!(tags_count, t => 1)
            end
        end
    end

    write(io, """<ul class="tag_counter" style=\"list-style : none;\">\n""")
    for t in tags_count
        write(io, """<li><a href="/tag/$(t.first)">$(t.first)</a>: $(t.second)</li>\n""")
    end
    write(io, "</ul>\n")
    write(io, "\n")
    return String(take!(io))
end

function hfun_getallposts()
    years = filter(x -> isdir(joinpath("blog", x)), readdir("blog"))
    @show years
    io = IOBuffer()
    write(io, "\n<ul>\n")
    for y in years
        write(io, "<li>$y\n")
        write(io, "<ul>\n")
        for post in sort!(readdir("blog/$y"); by = x -> stat(x).mtime)
            write(
                io,
                """<li>
            <a href="/blog/$y/$post">$post</a>
            ($(Dates.format(Dates.unix2datetime(stat(joinpath("blog", y, post)).mtime), "yyyy-mm-dd")))
            </li>\n""",
            )
        end
        write(io, "</ul>\n")
        write(io, "</li>\n")
    end
    write(io, "</ul>\n")

    return String(take!(io))
end
