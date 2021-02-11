#               _       _
#    __ _ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
#   / _` | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
#  | (_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
#   \__, |\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|
#      |_|

# Do not load autoconfig.yml
config.load_autoconfig(False)

# Bind keys to control content.proxy & use TOR by default
config.set('content.proxy', 'socks://localhost:9050/')
config.bind(',t', 'set content.proxy socks://localhost:9050/')
config.bind(',2', 'set content.proxy http://localhost:4444/')
config.bind(',P', 'set content.proxy system')

# Set custom User Agent
config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0')

# Set a generic HTTP_ACCEPT header
config.set("content.headers.accept_language", "en-US,en;q=0.5")
config.set("content.headers.custom", {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"})

# Disable reading from canvas
config.set("content.canvas_reading", False)

# Disable HTML 5 local storage and Web SQL
config.set("content.local_storage", False)

# Scripts
config.bind("pv", "spawn --userscript ~/.config/qutebrowser/scripts/view_in_mpv")

# Disable Javascript
config.set("content.javascript.enabled", False)
# Except on these domains
config.set("content.javascript.enabled", True, "https://start.duckduckgo.com/*")
config.set("content.javascript.enabled", True, "https://3g2upl4pq6kufc4m.onion/*")

# Disable cookies
config.set("content.cookies.accept", "never")
config.set("content.cookies.store", False)

# Special rules for my hidden service
with config.pattern('*://qxbpps3h5bfkrnuy55fljgc4hll45lmc7zfznmi4yypfy744m4v4y3qd.onion/*') as p:
    p.content.cookies.accept = "no-3rdparty"
    p.content.javascript.enabled = True

# Custom Adblock list file
# c.content.host_blocking.lists.append( str(config.configdir) + "/blockedHosts")

# Custom CSS
# c.content.user_stylesheets = ["css/main.css"]

# Change start/default pages + search engine
config.set("url.start_pages", "https://start.duckduckgo.com/?kae=t")
config.set("url.default_page", "https://start.duckduckgo.com/?kae=t")
config.set("url.searchengines", {
    # Main
    "DEFAULT": "https://start.duckduckgo.com/?q={}&kae=t"  ,
    "o"      : "https://3g2upl4pq6kufc4m.onion/?q={}&kae=t",

    # Arch Linux
    "pac": "https://archlinux.org/packages/?q={}"              ,
    "aur": "https://aur.archlinux.org/packages/?K={}"          ,
    "aw" : "https://wiki.archlinux.org/index.php?search={}"    ,
    "bug": "https://bugs.archlinux.org/index.php?string={}"    ,
    "man": "https://jlk.fjfi.cvut.cz/arch/manpages/search?q={}",

    # Wikimedia
    "w"  : "https://en.wikipedia.org/w/index.php?search={}",
    "wla": "https://la.wikipedia.org/w/index.php?search={}",
    "wpt": "https://pt.wikipedia.org/w/index.php?search={}",

    "wt"  : "https://en.wiktionary.org/w/index.php?search={}",
    "wtla": "https://la.wiktionary.org/w/index.php?search={}",
    "wtpt": "https://pt.wiktionary.org/w/index.php?search={}",

    "wq"  : "https://en.wikiquote.org/w/index.php?search={}",
    "wqla": "https://la.wikiquote.org/w/index.php?search={}",
    "wqpt": "https://pt.wikiquote.org/w/index.php?search={}",

    "wb"  : "https://en.wikibooks.org/w/index.php?search={}",
    "wbla": "https://la.wikibooks.org/w/index.php?search={}",
    "wbpt": "https://pt.wikibooks.org/w/index.php?search={}",

    "ws"  : "https://en.wikisource.org/w/index.php?search={}",
    "wsla": "https://la.wikisource.org/w/index.php?search={}",
    "wspt": "https://pt.wikisource.org/w/index.php?search={}",

    "wc": "https://commons.wikimedia.org/w/index.php?search={}",

    # Misc.
    "gutenberg": "https://gutenberg.org/ebooks/search/?query={}"          ,
    "libgen"   : "http://gen.lib.rus.ec/search.php?req={}"                ,
    "osm"      : "https://openstreetmap.org/search?query={}"              ,
    "perseus"  : "https://www.perseus.tufts.edu/hopper/searchresults?q={}",
})

# Set custom window title
config.set("window.title_format", "{perc}{current_title}")

# Tab settings
config.set("tabs.position", "bottom")
config.set("tabs.show", "multiple")
config.set("tabs.padding", {"top": 1, "bottom": 2, "left": 5, "right": 5})
config.set("tabs.indicator.width", 0)
config.set("tabs.favicons.scale", 1.2)

# Hide scroll bar
config.set("scrolling.bar", "never")

# Completion settings
config.set("completion.shrink", True)

# Disable case sensitivity for searching
config.set("search.ignore_case", "always")

# Confirm exit when downloading files
c.confirm_quit = ["downloads"]

# Fonts
c.fonts.default_size =  "9pt"
c.fonts.default_family = "Carot Mono Light"
c.fonts.completion.category = "10pt Carot Mono Light"
c.fonts.completion.entry = "10pt Carot Mono Light"
c.fonts.statusbar = "10pt Carot Mono Light"
c.fonts.downloads = "10pt Carot Mono Light"
c.fonts.hints = "bold 10pt Carot Mono Light"
c.fonts.debug_console = "10pt Carot Mono Light"


# Color Scheme
black = "#161821"
white = "#c6c8d1"
red = "#e27878"
green = "#b4be82"
yellow = "#e2a478"
blue = "#84a0c6"
magenta = "#a093c7"
cyan = "#89b8c2"

background = black
backgroundAlt = "#22262e"
accent = blue

# Set dark mode
config.set("colors.webpage.darkmode.enabled", True)

# Set colors from color scheme
c.colors.completion.category.bg = background
c.colors.completion.category.border.bottom = background
c.colors.completion.category.border.top = background
c.colors.completion.category.fg = accent
c.colors.completion.fg = white
c.colors.completion.item.selected.bg = backgroundAlt
c.colors.completion.item.selected.border.bottom = backgroundAlt
c.colors.completion.item.selected.border.top = backgroundAlt
c.colors.completion.item.selected.fg = accent
c.colors.completion.match.fg = white
c.colors.completion.odd.bg = background
c.colors.completion.even.bg = background
c.colors.completion.scrollbar.bg = background
c.colors.completion.scrollbar.fg = accent
c.colors.downloads.bar.bg = background
c.colors.downloads.error.fg = red
c.colors.downloads.start.bg = background
c.colors.downloads.start.fg = white
c.colors.downloads.stop.bg = background
c.colors.downloads.stop.fg = accent
c.colors.hints.bg = yellow
c.colors.hints.fg = background
c.colors.hints.match.fg = yellow
c.colors.keyhint.bg = background
c.colors.keyhint.fg = accent
c.colors.keyhint.suffix.fg = accent
c.colors.messages.error.fg = accent
c.colors.messages.error.bg = background
c.colors.messages.error.border = background
c.colors.messages.info.bg = background
c.colors.messages.info.border = background
c.colors.messages.info.fg = accent
c.colors.messages.warning.bg = red
c.colors.messages.warning.border = red
c.colors.messages.warning.fg = background
c.colors.prompts.bg = background
c.colors.prompts.border = background
c.colors.prompts.fg = white
c.colors.prompts.selected.bg = accent
c.colors.statusbar.caret.bg = accent
c.colors.statusbar.caret.fg = background
c.colors.statusbar.caret.selection.bg = accent
c.colors.statusbar.caret.selection.fg = background
c.colors.statusbar.command.bg = backgroundAlt
c.colors.statusbar.command.fg = accent
c.colors.statusbar.command.private.bg = backgroundAlt
c.colors.statusbar.command.private.fg = accent
c.colors.statusbar.insert.bg = backgroundAlt
c.colors.statusbar.insert.fg = accent
c.colors.statusbar.normal.bg = background
c.colors.statusbar.normal.fg = accent
c.colors.statusbar.passthrough.bg = accent
c.colors.statusbar.passthrough.fg = background
c.colors.statusbar.private.bg = background
c.colors.statusbar.private.fg = accent
c.colors.statusbar.progress.bg = accent
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.fg = background
c.colors.statusbar.url.hover.fg = accent
c.colors.statusbar.url.success.http.fg = accent
c.colors.statusbar.url.success.https.fg = accent
c.colors.statusbar.url.warn.fg = red
c.colors.tabs.bar.bg = background
c.colors.tabs.even.bg = background
c.colors.tabs.even.fg = white
c.colors.tabs.indicator.error = background
c.colors.tabs.indicator.start = accent
c.colors.tabs.indicator.stop = background
c.colors.tabs.odd.bg = background
c.colors.tabs.odd.fg = white
c.colors.tabs.selected.even.bg = backgroundAlt
c.colors.tabs.selected.even.fg = accent
c.colors.tabs.selected.odd.bg = backgroundAlt
c.colors.tabs.selected.odd.fg = accent
# c.colors.webpage.bg = background
