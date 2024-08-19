/* Formatted on 8/19/2024 9:03:14 PM (QP5 v5.256.13226.35510) */
SELECT head.name header_name,
       head.je_source,
       head.je_category,
       head.DOC_SEQUENCE_VALUE document_number,
       head.CURRENCY_CODE,
       head.je_source source,
       line.je_line_num AS line_number,
          gcc.segment1
       || '-'
       || gcc.segment2
       || '-'
       || gcc.segment3
       || '-'
       || gcc.segment4
          AS account,
       gcc.description AS account_description,
       line.entered_dr AS debit,
       line.entered_cr AS credit,
       GL_FLEXFIELDS_PKG.get_description_sql (gcc.chart_of_accounts_id,
                                              1,
                                              gcc.segment1)
          AS ACCOUNTING_FLEX_DESC
       
  --       line.accounting_flexfield
  FROM gl_je_headers head,
       gl_je_lines line,
       gl_code_combinations_kfv gcc,
       gl_je_sources_tl gjst
 WHERE     head.je_header_id = line.je_header_id
       AND line.code_combination_id = gcc.code_combination_id
       AND head.je_source = gjst.je_source_key
       --       AND head.ledger_id = :p_ledger_id
       AND head.je_header_id = 4695272