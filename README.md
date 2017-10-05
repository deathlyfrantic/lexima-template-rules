![PRs welcome but not actively maintained](https://img.shields.io/badge/status-PRs%20welcome%20but%20not%20actively%20maintained-red.svg?style=flat-square)

## Lexima Rules for Web Templates

[Lexima](https://github.com/cohama/lexima.vim) is great, but does not include any rules for web templates, so I wrote
some. Then I figured other people might find them useful, so I pulled them out of my `init.vim` and here they are.

#### Getting Started

Use your favorite plugin manager. I like [Vim-Plug](https://github.com/junegunn/vim-plug). You must have Lexima.

#### Behavior

In all cases below, `|` represents the cursor position.

For all templates, including plain HTML and XML:

    Before                      Input                   After
    ----------------------------------------------------------------------------
    |                           <                       <|>
    ----------------------------------------------------------------------------
    <|> or <|/>                 <Backspace>             |
    ----------------------------------------------------------------------------
    <tag>| or <tag/>|           <Backspace>             <tag|> or <tag|/>
    ----------------------------------------------------------------------------
    <tag foo="bar"|>            /                       <tag foo="bar"/>|
    ----------------------------------------------------------------------------
    <tag|/>                     /                       <tag/>|
    ----------------------------------------------------------------------------
    <tag>|</tag>                <Enter>                 <tag>
                                                            |
                                                        </tag>
    ----------------------------------------------------------------------------

For Django, Jinja2, Twig and Liquid templates (as appropriate):

    Before                      Input                   After
    ----------------------------------------------------------------------------
    {|}                         % or #                  {%|%} or {#|#}
    ----------------------------------------------------------------------------
    {%|%}                       -                       {%-|-%}
    ----------------------------------------------------------------------------
    {%|%}                       <Space>                 {% | %}
    ----------------------------------------------------------------------------
    {%-|-%}                     <Space>                 {%- | -%}
    ----------------------------------------------------------------------------
    {%- | -%}                   <Backspace>             {%-|-%}
    ----------------------------------------------------------------------------
    {% | %}                     <Backspace>             {%|%}
    ----------------------------------------------------------------------------
    {%-|-%}                     <Backspace>             {%|%}
    ----------------------------------------------------------------------------
    {%|%}                       <Backspace>             {|}
    ----------------------------------------------------------------------------
    {{ foo| }} or {{ foo |}}    }                       {{ foo }}|
    ----------------------------------------------------------------------------
    {{ foo }}|                  <Backspace>             {{ foo| }}
    ----------------------------------------------------------------------------
    {% tag| %}                  % or }                  {% tag %}|
    ----------------------------------------------------------------------------
    {% tag %}|                  <Backspace>             {% tag| %}
    ----------------------------------------------------------------------------
    {% if foo %}|               <Enter>                 {% if foo %}
                                                            |
                                                        {% endif %}
    ----------------------------------------------------------------------------

For Mako templates:

    Before                      Input                   After
    ----------------------------------------------------------------------------
    <%def name="foo">|          <Enter>                 <%def name="foo">
                                                            |
                                                        </%def>
    ----------------------------------------------------------------------------
    % for foo in bar:|          <Enter>                 % for foo in bar:
                                                            |
                                                        % endfor
    ----------------------------------------------------------------------------
    <%| or <%!|                 <Enter>                 <% or <%!
                                                            |
                                                        %>
    ----------------------------------------------------------------------------
    <%inheri|>                  t                       <%inherit|/>
    ----------------------------------------------------------------------------
    <%namespace|/>              <Backspace>             <%namespac|>
    ----------------------------------------------------------------------------

#### Template Systems

There are rules for the following template systems:
- [Django](https://docs.djangoproject.com/en/dev/topics/templates/)
- [Jinja2](http://jinja.pocoo.org/)
- [Twig](http://twig.sensiolabs.org/)
- [Liquid](https://shopify.github.io/liquid/)
- [Mako](http://www.makotemplates.org)

If there are other template systems with syntax similar to that of any of the above, I will be glad to add them to these
rules (or accept pull requests).

#### Options

In Jinja2 and Twig templates, I rarely use `set` blocks. By default, these rules will not add `{% endset %}` for you. If
you want `endset`s added, `let g:lexima_template_rules_endset = 1` in your `.vimrc` or `init.vim`.
