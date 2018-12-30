# natrénování modelu z conlluu souboru

library(udpipe)

file_conllu <- 'cs_cac-ud-dev.conllu' # než si troufnu na ud-train...

params <- list()

## Tokenizer training parameters
params$tokenizer <- list(dimension = 24, 
                         #epochs = 1,
                         epochs = 100, 
                         initialization_range = 0.1, 
                         batch_size = 100, learning_rate = 0.005, 
                         dropout = 0.1, early_stopping = 1)

## Tagger training parameters
params$tagger <- list(models = 2, 
                      templates_1 = "tagger", 
                      guesser_suffix_rules_1 = 8, guesser_enrich_dictionary_1 = 6, 
                      guesser_prefixes_max_1 = 0, 
                      use_lemma_1 = 0, use_xpostag_1 = 1, use_feats_1 = 1, 
                      provide_lemma_1 = 0, provide_xpostag_1 = 1, 
                      provide_feats_1 = 1, prune_features_1 = 0, 
                      templates_2 = "lemmatizer", 
                      guesser_suffix_rules_2 = 6, guesser_enrich_dictionary_2 = 4, 
                      guesser_prefixes_max_2 = 4, 
                      use_lemma_2 = 1, use_xpostag_2 = 0, use_feats_2 = 0, 
                      provide_lemma_2 = 1, provide_xpostag_2 = 0, 
                      provide_feats_2 = 0, prune_features_2 = 0)

## Dependency parser training parameters
params$parser <- list(#iterations = 1, 
                      iterations = 30, 
                      embedding_upostag = 20, embedding_feats = 20, embedding_xpostag = 0, 
                      embedding_form = 50, 
                      #embedding_form_file = "../ud-2.0-embeddings/nl.skip.forms.50.vectors", 
                      embedding_lemma = 0, embedding_deprel = 20, 
                      learning_rate = 0.01, learning_rate_final = 0.001, l2 = 0.5, hidden_layer = 200, 
                      batch_size = 10, transition_system = "projective", transition_oracle = "dynamic", 
                      structured_interval = 10)

## Train the model
m <- udpipe_train(file = "jla-cac.udpipe", 
                  files_conllu_training = file_conllu, 
                  annotation_tokenizer = params$tokenizer,
                  annotation_tagger    = params$tagger,
                  annotation_parser    = params$parser)

