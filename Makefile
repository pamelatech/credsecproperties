LIBDIR := lib
-include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update --init
else
ifneq (,$(wildcard $(ID_TEMPLATE_HOME)))
	ln -s "$(ID_TEMPLATE_HOME)" $(LIBDIR)
else
	git clone -q --depth 10 -b main \
	    https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
endif

# Build the rich, datatracker-style PDF (hyperlinks, bookmarks, real fonts) via
# xml2rfc/weasyprint instead of lib/main.mk's plain-text enscript|ps2pdf rule.
# This is a static pattern rule, so its explicit targets take precedence over
# the generic `%.pdf: %.txt` pattern in lib/main.mk.
#
# weasyprint is an opt-in dependency; see requirements-pdf.txt for why it is
# not installed automatically and how to install it. This rule is inert until
# you do, and `make pdf` is never invoked by CI.
# On macOS it locates Homebrew's pango/cairo via DYLD_FALLBACK_LIBRARY_PATH.
ifeq (Darwin,$(shell uname -s))
weasyprint-env := DYLD_FALLBACK_LIBRARY_PATH="$(shell brew --prefix)/lib"
endif

$(addsuffix .pdf,$(drafts)): %.pdf: %.xml
	$(weasyprint-env) $(xml2rfc) --pdf $< -o $@
