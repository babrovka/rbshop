# модуль для генерирования кастомных урлов
# урлы содержать много параметров,
# которые прописать в автоматическом режиме
module PolyUrlsHelper

  # урл публичной страницы таксона
  def poly_taxon_path(taxon)
    if taxon.taxonomy
      taxon_path(taxonomy: taxon.taxonomy, id: taxon.id)
    else
      taxon_path('no_taxonomy', taxon)
    end
  end

  # урл публичной страницы таксономии
  def poly_taxonomy_path(taxonomy)
    taxonomy_path(taxonomy)
  end

end
