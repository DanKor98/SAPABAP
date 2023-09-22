*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZMJ_WORKPOS_T
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZMJ_WORKPOS_T      .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
