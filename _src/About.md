# About page

```pgtree
{PLANNEDSTMT 
	   :commandType 1 
	   :queryId 0 
	   :hasReturning false 
	   :hasModifyingCTE false 
	   :canSetTag true 
	   :transientPlan false 
	   :dependsOnRole false 
	   :parallelModeNeeded false 
	   :jitFlags 0 
	   :planTree 
	      {LIMIT 
	      :startup_cost 45012.49 
	      :total_cost 45012.50 
	      :plan_rows 1 
	      :plan_width 36 
	      :parallel_aware false 
	      :parallel_safe false 
	      :plan_node_id 0 
	      :targetlist (
	         {TARGETENTRY 
	         :expr 
	            {VAR 
	            :varno 65001 
	            :varattno 1 
	            :vartype 23 
	            :vartypmod -1 
	            :varcollid 0 
	            :varlevelsup 0 
	            :varnoold 1 
	            :varoattno 1 
	            :location -1
	            }
	         :resno 1 
	         :resname user_id 
	         :ressortgroupref 1 
	         :resorigtbl 16890 
	         :resorigcol 1 
	         :resjunk false
	         }
	         {TARGETENTRY 
	         :expr 
	            {VAR 
	            :varno 65001 
	            :varattno 2 
	            :vartype 1700 
	            :vartypmod -1 
	            :varcollid 0 
	            :varlevelsup 0 
	            :varnoold 0 
	            :varoattno 0 
	            :location -1
	            }
	         :resno 2 
	         :resname avg 
	         :ressortgroupref 2 
	         :resorigtbl 0 
	         :resorigcol 0 
	         :resjunk false
	         }
	      )
	      :qual <> 
	      :lefttree 
	         {SORT 
	         :startup_cost 45012.49 
	         :total_cost 45012.50 
	         :plan_rows 1 
	         :plan_width 36 
	         :parallel_aware false 
	         :parallel_safe false 
	         :plan_node_id 1 
	         :targetlist (
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 65001 
	               :varattno 1 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 1 
	               :varoattno 1 
	               :location -1
	               }
	            :resno 1 
	            :resname user_id 
	            :ressortgroupref 1 
	            :resorigtbl 16890 
	            :resorigcol 1 
	            :resjunk false
	            }
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 65001 
	               :varattno 2 
	               :vartype 1700 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 0 
	               :varoattno 0 
	               :location -1
	               }
	            :resno 2 
	            :resname avg 
	            :ressortgroupref 2 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	         )
	         :qual <> 
	         :lefttree 
	            {AGG 
	            :startup_cost 45012.46 
	            :total_cost 45012.48 
	            :plan_rows 1 
	            :plan_width 36 
	            :parallel_aware false 
	            :parallel_safe false 
	            :plan_node_id 2 
	            :targetlist (
	               {TARGETENTRY 
	               :expr 
	                  {VAR 
	                  :varno 65001 
	                  :varattno 1 
	                  :vartype 23 
	                  :vartypmod -1 
	                  :varcollid 0 
	                  :varlevelsup 0 
	                  :varnoold 0 
	                  :varoattno 0 
	                  :location -1
	                  }
	               :resno 1 
	               :resname user_id 
	               :ressortgroupref 1 
	               :resorigtbl 16890 
	               :resorigcol 1 
	               :resjunk false
	               }
	               {TARGETENTRY 
	               :expr 
	                  {AGGREF 
	                  :aggfnoid 2101 
	                  :aggtype 1700 
	                  :aggcollid 0 
	                  :inputcollid 0 
	                  :aggtranstype 1016 
	                  :aggargtypes (o 23)
	                  :aggdirectargs <> 
	                  :args (
	                     {TARGETENTRY 
	                     :expr 
	                        {VAR 
	                        :varno 65001 
	                        :varattno 2 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 4 
	                        :location 29
	                        }
	                     :resno 1 
	                     :resname <> 
	                     :ressortgroupref 0 
	                     :resorigtbl 0 
	                     :resorigcol 0 
	                     :resjunk false
	                     }
	                  )
	                  :aggorder <> 
	                  :aggdistinct <> 
	                  :aggfilter <> 
	                  :aggstar false 
	                  :aggvariadic false 
	                  :aggkind n 
	                  :agglevelsup 0 
	                  :aggsplit 0 
	                  :location 25
	                  }
	               :resno 2 
	               :resname avg 
	               :ressortgroupref 2 
	               :resorigtbl 0 
	               :resorigcol 0 
	               :resjunk false
	               }
	            )
	            :qual <> 
	            :lefttree 
	               {SORT 
	               :startup_cost 45012.46 
	               :total_cost 45012.46 
	               :plan_rows 1 
	               :plan_width 8 
	               :parallel_aware false 
	               :parallel_safe false 
	               :plan_node_id 3 
	               :targetlist (
	                  {TARGETENTRY 
	                  :expr 
	                     {VAR 
	                     :varno 65001 
	                     :varattno 1 
	                     :vartype 23 
	                     :vartypmod -1 
	                     :varcollid 0 
	                     :varlevelsup 0 
	                     :varnoold 1 
	                     :varoattno 1 
	                     :location -1
	                     }
	                  :resno 1 
	                  :resname <> 
	                  :ressortgroupref 1 
	                  :resorigtbl 0 
	                  :resorigcol 0 
	                  :resjunk false
	                  }
	                  {TARGETENTRY 
	                  :expr 
	                     {VAR 
	                     :varno 65001 
	                     :varattno 2 
	                     :vartype 23 
	                     :vartypmod -1 
	                     :varcollid 0 
	                     :varlevelsup 0 
	                     :varnoold 1 
	                     :varoattno 4 
	                     :location -1
	                     }
	                  :resno 2 
	                  :resname <> 
	                  :ressortgroupref 0 
	                  :resorigtbl 0 
	                  :resorigcol 0 
	                  :resjunk false
	                  }
	               )
	               :qual <> 
	               :lefttree 
	                  {SEQSCAN 
	                  :startup_cost 0.00 
	                  :total_cost 45012.45 
	                  :plan_rows 1 
	                  :plan_width 8 
	                  :parallel_aware false 
	                  :parallel_safe false 
	                  :plan_node_id 4 
	                  :targetlist (
	                     {TARGETENTRY 
	                     :expr 
	                        {VAR 
	                        :varno 1 
	                        :varattno 1 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 1 
	                        :location 7
	                        }
	                     :resno 1 
	                     :resname <> 
	                     :ressortgroupref 1 
	                     :resorigtbl 0 
	                     :resorigcol 0 
	                     :resjunk false
	                     }
	                     {TARGETENTRY 
	                     :expr 
	                        {VAR 
	                        :varno 1 
	                        :varattno 4 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 4 
	                        :location 29
	                        }
	                     :resno 2 
	                     :resname <> 
	                     :ressortgroupref 0 
	                     :resorigtbl 0 
	                     :resorigcol 0 
	                     :resjunk false
	                     }
	                  )
	                  :qual (
	                     {OPEXPR 
	                     :opno 521 
	                     :opfuncid 147 
	                     :opresulttype 16 
	                     :opretset false 
	                     :opcollid 0 
	                     :inputcollid 0 
	                     :args (
	                        {VAR 
	                        :varno 1 
	                        :varattno 3 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 3 
	                        :location 69
	                        }
	                        {CONST 
	                        :consttype 23 
	                        :consttypmod -1 
	                        :constcollid 0 
	                        :constlen 4 
	                        :constbyval true 
	                        :constisnull false 
	                        :location 79 
	                        :constvalue 4 [ 1 0 0 0 0 0 0 0 ]
	                        }
	                     )
	                     :location 77
	                     }
	                     {OPEXPR 
	                     :opno 97 
	                     :opfuncid 66 
	                     :opresulttype 16 
	                     :opretset false 
	                     :opcollid 0 
	                     :inputcollid 0 
	                     :args (
	                        {VAR 
	                        :varno 1 
	                        :varattno 3 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 3 
	                        :location 94
	                        }
	                        {CONST 
	                        :consttype 23 
	                        :consttypmod -1 
	                        :constcollid 0 
	                        :constlen 4 
	                        :constbyval true 
	                        :constisnull false 
	                        :location 104 
	                        :constvalue 4 [ 3 0 0 0 0 0 0 0 ]
	                        }
	                     )
	                     :location 102
	                     }
	                     {OPEXPR 
	                     :opno 525 
	                     :opfuncid 150 
	                     :opresulttype 16 
	                     :opretset false 
	                     :opcollid 0 
	                     :inputcollid 0 
	                     :args (
	                        {VAR 
	                        :varno 1 
	                        :varattno 4 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 4 
	                        :location 119
	                        }
	                        {CONST 
	                        :consttype 23 
	                        :consttypmod -1 
	                        :constcollid 0 
	                        :constlen 4 
	                        :constbyval true 
	                        :constisnull false 
	                        :location 130 
	                        :constvalue 4 [ 1 0 0 0 0 0 0 0 ]
	                        }
	                     )
	                     :location 127
	                     }
	                     {SUBPLAN 
	                     :subLinkType 0 
	                     :testexpr <> 
	                     :paramIds <> 
	                     :plan_id 1 
	                     :plan_name SubPlan\ 1 
	                     :firstColType 23 
	                     :firstColTypmod -1 
	                     :firstColCollation 0 
	                     :useHashTable false 
	                     :unknownEqFalse true 
	                     :parallel_safe false 
	                     :setParam <> 
	                     :parParam (i 0)
	                     :args (
	                        {VAR 
	                        :varno 1 
	                        :varattno 1 
	                        :vartype 23 
	                        :vartypmod -1 
	                        :varcollid 0 
	                        :varlevelsup 0 
	                        :varnoold 1 
	                        :varoattno 1 
	                        :location 386
	                        }
	                     )
	                     :startup_cost 0.00 
	                     :per_call_cost 35.42
	                     }
	                  )
	                  :lefttree <> 
	                  :righttree <> 
	                  :initPlan <> 
	                  :extParam (b)
	                  :allParam (b)
	                  :scanrelid 1
	                  }
	               :righttree <> 
	               :initPlan <> 
	               :extParam (b)
	               :allParam (b)
	               :numCols 1 
	               :sortColIdx 1 
	               :sortOperators 521 
	               :collations 0 
	               :nullsFirst true
	               }
	            :righttree <> 
	            :initPlan <> 
	            :extParam (b)
	            :allParam (b)
	            :aggstrategy 1 
	            :aggsplit 0 
	            :numCols 1 
	            :grpColIdx 1 
	            :grpOperators 96 
	            :numGroups 1 
	            :aggParams (b)
	            :groupingSets <> 
	            :chain <>
	            }
	         :righttree <> 
	         :initPlan <> 
	         :extParam (b)
	         :allParam (b)
	         :numCols 2 
	         :sortColIdx 1 2 
	         :sortOperators 521 1756 
	         :collations 0 0 
	         :nullsFirst true true
	         }
	      :righttree <> 
	      :initPlan <> 
	      :extParam (b)
	      :allParam (b)
	      :limitOffset <> 
	      :limitCount 
	         {CONST 
	         :consttype 20 
	         :consttypmod -1 
	         :constcollid 0 
	         :constlen 8 
	         :constbyval true 
	         :constisnull false 
	         :location -1 
	         :constvalue 8 [ 5 0 0 0 0 0 0 0 ]
	         }
	      }
	   :rtable (
	      {RTE 
	      :alias <> 
	      :eref 
	         {ALIAS 
	         :aliasname users_table2 
	         :colnames ("user_id" "time" "value_1" "value_2" "value_3" "value_4")
	         }
	      :rtekind 0 
	      :relid 16890 
	      :relkind r 
	      :tablesample <> 
	      :lateral false 
	      :inh false 
	      :inFromCl true 
	      :requiredPerms 2 
	      :checkAsUser 0 
	      :selectedCols (b 9 11 12)
	      :insertedCols (b)
	      :updatedCols (b)
	      :securityQuals <>
	      }
	      {RTE 
	      :alias <> 
	      :eref 
	         {ALIAS 
	         :aliasname events_table2 
	         :colnames ("user_id" "time" "event_type" "value_2" "value_3" "value_4
	         ")
	         }
	      :rtekind 0 
	      :relid 16893 
	      :relkind r 
	      :tablesample <> 
	      :lateral false 
	      :inh false 
	      :inFromCl true 
	      :requiredPerms 2 
	      :checkAsUser 0 
	      :selectedCols (b 9 11 13)
	      :insertedCols (b)
	      :updatedCols (b)
	      :securityQuals <>
	      }
	   )
	   :resultRelations <> 
	   :nonleafResultRelations <> 
	   :rootResultRelations <> 
	   :subplans (
	      {AGG 
	      :startup_cost 0.00 
	      :total_cost 35.42 
	      :plan_rows 1 
	      :plan_width 4 
	      :parallel_aware false 
	      :parallel_safe false 
	      :plan_node_id 5 
	      :targetlist (
	         {TARGETENTRY 
	         :expr 
	            {VAR 
	            :varno 65001 
	            :varattno 1 
	            :vartype 23 
	            :vartypmod -1 
	            :varcollid 0 
	            :varlevelsup 0 
	            :varnoold 0 
	            :varoattno 0 
	            :location -1
	            }
	         :resno 1 
	         :resname user_id 
	         :ressortgroupref 1 
	         :resorigtbl 16893 
	         :resorigcol 1 
	         :resjunk false
	         }
	      )
	      :qual (
	         {OPEXPR 
	         :opno 419 
	         :opfuncid 477 
	         :opresulttype 16 
	         :opretset false 
	         :opcollid 0 
	         :inputcollid 0 
	         :args (
	            {AGGREF 
	            :aggfnoid 2803 
	            :aggtype 20 
	            :aggcollid 0 
	            :inputcollid 0 
	            :aggtranstype 20 
	            :aggargtypes <> 
	            :aggdirectargs <> 
	            :args <> 
	            :aggorder <> 
	            :aggdistinct <> 
	            :aggfilter <> 
	            :aggstar true 
	            :aggvariadic false 
	            :aggkind n 
	            :agglevelsup 0 
	            :aggsplit 0 
	            :location 474
	            }
	            {CONST 
	            :consttype 23 
	            :consttypmod -1 
	            :constcollid 0 
	            :constlen 4 
	            :constbyval true 
	            :constisnull false 
	            :location 485 
	            :constvalue 4 [ 2 0 0 0 0 0 0 0 ]
	            }
	         )
	         :location 483
	         }
	      )
	      :lefttree 
	         {SEQSCAN 
	         :startup_cost 0.00 
	         :total_cost 35.40 
	         :plan_rows 1 
	         :plan_width 4 
	         :parallel_aware false 
	         :parallel_safe false 
	         :plan_node_id 6 
	         :targetlist (
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 2 
	               :varattno 1 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 1 
	               :location -1
	               }
	            :resno 1 
	            :resname <> 
	            :ressortgroupref 1 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 2 
	               :varattno 2 
	               :vartype 1114 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 2 
	               :location -1
	               }
	            :resno 2 
	            :resname <> 
	            :ressortgroupref 0 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 2 
	               :varattno 3 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 3 
	               :location -1
	               }
	            :resno 3 
	            :resname <> 
	            :ressortgroupref 0 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 2 
	               :varattno 4 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 4 
	               :location -1
	               }
	            :resno 4 
	            :resname <> 
	            :ressortgroupref 0 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 2 
	               :varattno 5 
	               :vartype 701 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 5 
	               :location -1
	               }
	            :resno 5 
	            :resname <> 
	            :ressortgroupref 0 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	            {TARGETENTRY 
	            :expr 
	               {VAR 
	               :varno 2 
	               :varattno 6 
	               :vartype 20 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 6 
	               :location -1
	               }
	            :resno 6 
	            :resname <> 
	            :ressortgroupref 0 
	            :resorigtbl 0 
	            :resorigcol 0 
	            :resjunk false
	            }
	         )
	         :qual (
	            {OPEXPR 
	            :opno 521 
	            :opfuncid 147 
	            :opresulttype 16 
	            :opretset false 
	            :opcollid 0 
	            :inputcollid 0 
	            :args (
	               {VAR 
	               :varno 2 
	               :varattno 3 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 3 
	               :location 238
	               }
	               {CONST 
	               :consttype 23 
	               :consttypmod -1 
	               :constcollid 0 
	               :constlen 4 
	               :constbyval true 
	               :constisnull false 
	               :location 251 
	               :constvalue 4 [ 1 0 0 0 0 0 0 0 ]
	               }
	            )
	            :location 249
	            }
	            {OPEXPR 
	            :opno 97 
	            :opfuncid 66 
	            :opresulttype 16 
	            :opretset false 
	            :opcollid 0 
	            :inputcollid 0 
	            :args (
	               {VAR 
	               :varno 2 
	               :varattno 3 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 3 
	               :location 285
	               }
	               {CONST 
	               :consttype 23 
	               :consttypmod -1 
	               :constcollid 0 
	               :constlen 4 
	               :constbyval true 
	               :constisnull false 
	               :location 298 
	               :constvalue 4 [ 3 0 0 0 0 0 0 0 ]
	               }
	            )
	            :location 296
	            }
	            {OPEXPR 
	            :opno 674 
	            :opfuncid 297 
	            :opresulttype 16 
	            :opretset false 
	            :opcollid 0 
	            :inputcollid 0 
	            :args (
	               {VAR 
	               :varno 2 
	               :varattno 5 
	               :vartype 701 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 5 
	               :location 332
	               }
	               {CONST 
	               :consttype 701 
	               :consttypmod -1 
	               :constcollid 0 
	               :constlen 8 
	               :constbyval true 
	               :constisnull false 
	               :location -1 
	               :constvalue 8 [ 0 0 0 0 0 0 -16 63 ]
	               }
	            )
	            :location 340
	            }
	            {OPEXPR 
	            :opno 96 
	            :opfuncid 65 
	            :opresulttype 16 
	            :opretset false 
	            :opcollid 0 
	            :inputcollid 0 
	            :args (
	               {VAR 
	               :varno 2 
	               :varattno 1 
	               :vartype 23 
	               :vartypmod -1 
	               :varcollid 0 
	               :varlevelsup 0 
	               :varnoold 2 
	               :varoattno 1 
	               :location 376
	               }
	               {PARAM 
	               :paramkind 1 
	               :paramid 0 
	               :paramtype 23 
	               :paramtypmod -1 
	               :paramcollid 0 
	               :location 386
	               }
	            )
	            :location 384
	            }
	         )
	         :lefttree <> 
	         :righttree <> 
	         :initPlan <> 
	         :extParam (b 0)
	         :allParam (b 0)
	         :scanrelid 2
	         }
	      :righttree <> 
	      :initPlan <> 
	      :extParam (b 0)
	      :allParam (b 0)
	      :aggstrategy 1 
	      :aggsplit 0 
	      :numCols 1 
	      :grpColIdx 1 
	      :grpOperators 96 
	      :numGroups 1 
	      :aggParams (b)
	      :groupingSets <> 
	      :chain <>
	      }
	   )
	   :rewindPlanIDs (b)
	   :rowMarks <> 
	   :relationOids (o 16890 16893)
	   :invalItems <> 
	   :paramExecTypes (o 23)
	   :utilityStmt <> 
	   :stmt_location 0 
	   :stmt_len 542
	   }
```
