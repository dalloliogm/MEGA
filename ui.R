library(shiny)
library(shinyjs)
library(shinythemes)

panel_width = 3
result_with = 10

appCSS <- ".mandatory_star { color: red; }"

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(#theme = shinytheme("cerulean"),
            # theme='cloneR.css',
    navbarPage("MEGA-RVs",

             tabPanel("MEGA-RVs",

                      titlePanel("MEGA-RVs"),
                      h4("Mutational Enrichment Gene set Analysis of Rare Variants"),
                      shinyjs::useShinyjs(),
                      shinyjs::inlineCSS(appCSS),

                      sidebarLayout(
                        sidebarPanel(
                                 fileInput('cohort_A', 'Cohort A (tab-separated file)*', accept = c('text/tab-separated-values', '.tsv' )),
                                 fileInput('cohort_B', 'Cohort B (tab-separated file)*', accept = c('text/tab-separated-values', '.tsv' )),
                                 fileInput('gene_set', 'Gene Set*'),
                                 sliderInput("fdr",    'False Discovery Rate', min=0, max=1, value=0.1),
                                 selectInput("bootstrapping", 'Bootstrapping', choices=c("True","False"), selected="True"),
                                 numericInput("nsim", "Number of simulations", value=1000),
                                 p("Mandatory fields are marked with *"),
                                 actionButton("submit", "Run MEGA-RVs", class = "btn-primary"),
                                 downloadButton('downloadData', 'Download Results')

                               ),

                        # MAIN PANEL
                        mainPanel(
                          dataTableOutput('mega_results')
                         )
                       )
             ),

             tabPanel("Help",
                      titlePanel("Help page"),
                      withTags({
                        div(class="header", checked=NA,
                            p("MEGA-RVs was developed to identify predefined gene
                              sets (e.g. genes involved in the same pathway, or predisposing
                              to specific diseases) that show a significantly higher number
                              of mutations in a group of samples as compared to another
                              group of samples.")
                        )}),
                      withTags({
                        div(class="body", checked=NA,
                            h4("Arguments"),
                            p(strong("A and B")," = Boolean matrices of mutations. Coloums are samples, while rows are
                              mutations. The first coloumn must always contain the name of thegene in which
                              the mutation fall."),
                            p("Example:"),
                            p("Symbol\tSample1\tSample2\tSample3"),
                            p("GeneA\tTRUE\tFALSE\tFALSE"),
                            p("GeneA\tTRUE\tTRUE\tFALSE"),
                            p("GeneB\tTRUE\tFALSE\tTRUE"),
                            p("GeneC\tFALSE\tFALSE\tFALSE"),
                            p("GeneC\tFALSE\tTRUE\tFALSE"),
                            p("GeneD\tTRUE\tTRUE\tFALSE"),
                            p(strong("gene.sets")," = List of gene sets. Each element of the list is set of genes and
                              the name of each element of the list must be the name of the gene set."),
                            p("Example:"),
                            p(code("gene.sets = list(g1=c('MAST2','ABCA10','ASPM'),g2=c('TP53','ZNF572','MYC'))")),

                            p(strong("fdr_th")," = false discovery rate threshold (default is 0.1)"),

                            p(strong("bootstrapping"), " = If equal to true the bootstrapping strategy is performed
                              to assess the effect of the sample size"),

                            p(strong("nsim")," = number of iterations used in the bootsrapping strategy (default is 1000)")
                        )})




                      )

    )
  )
)
