;; extends

; Fixes fenced php blocks that dont start with the <?php tag
(fenced_code_block
  (info_string
    (language) @_lang)
  (code_fence_content) @injection.content
  (#eq? @_lang "php")
  (#set! injection.language "php_only"))
