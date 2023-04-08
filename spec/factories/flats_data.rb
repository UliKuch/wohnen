FactoryBot.define do
  factory :formatted_flats_data, class: Array do
    skip_create

    transient do
      first_external_id { "flat_#{SecureRandom.hex}" }
      second_external_id { "flat_#{SecureRandom.hex}" }
    end

    initialize_with do
      new([
        {
          "external_id"=>first_external_id,
          "link"=>"https://inberlinwohnen.de/asd::321/654/987.html",
          "attr"=> {
            "Miete"=>"987,00 €",
            "Adresse"=>"Tolle Straße 35A, Irgendwo",
            "Zimmeranzahl"=>"3,00",
            "Wohnfläche"=>"80,00 m²",
            "Bezugsfertig ab"=>"ab sofort",
            "Etage"=>"3 (von insg. 6)",
            "Baujahr"=>"2023",
            "Hauptenergieträger"=>"Fernwärme",
            "Energieausweis"=>"bedarfsausweis"
          }
        }, {
          "external_id"=>second_external_id,
          "link"=>"https://inberlinwohnen.de/dsa::987/654/321.html",
          "attr"=> {
            "Miete"=>"1.234,00 €",
            "Adresse"=>"Andere Straße 60, Woanders",
            "Zimmeranzahl"=>"4,00",
            "Wohnfläche"=>"85,00 m²",
            "Bezugsfertig ab"=>"ab sofort",
            "Etage"=>"4 (von insg. 6)",
            "Baujahr"=>"2023",
            "Hauptenergieträger"=>"Fernwärme",
            "Energieausweis"=>"bedarfsausweis"
          }
        }
      ])
    end
  end

  factory :raw_flats_data, class: String do
    skip_create

    transient do
      first_external_id { "flat_#{SecureRandom.hex}" }
      second_external_id { "flat_#{SecureRandom.hex}" }
    end

    initialize_with do
      new(
        <<~HTML
          <li id="#{first_external_id}" class="tb-merkflat ipg">
          <h3 id="mfh1234567"><span><span class="_tb_left"><strong>3</strong> Zimmer, <strong>80,00</strong>  m², <strong>987,00</strong>  € | Tolle Straße 35A, Irgendwo</span><span class="_tb_right"><a title="Balkon/Terasse" class="icon nohand2 balkon_loggia_terrasse"></a>
          <a title="Aufzug" class="icon aufzug nohand2"></a>
          </span></span></h3>                   
          <div id="mfd1234567" class="tb-merkdetails">
          <h2>3-Zimmer-Wohnung / ohne WBS!</h2>
          <div class="section group">
          <div class="list_col span_wflist_image">
          <figure class="flat-image wide" style="background-image:url(https://inberlinwohnen.de/wp-content/themes/ibw/images/flat-dummy.jpg);">
          <img src="https://inberlinwohnen.de/wp-content/themes/ibw/images/square-image.gif" alt="">
          </figure>
          <a title="Die detailierte Wohnungsanzeige öffnet in einem neuen Fenster" class="org-but" href="/asd::321/654/987.html" target="_blank">Alle Details</a>
          </div>
          <div class="list_col span_wflist_data">
          <table class="tb-small-data fullw"><tbody>
          <tr>
          <th>Adresse: </th>
          <td class="alg_r"><a title="Auf Karte anzeigen" class="map-but" href="#" onclick="openOverlay('nmap-1234567','de'); return false;">Tolle Straße 35A, Irgendwo</a></td>
          </tr>
          <tr>
          <th>Zimmeranzahl: </th>
          <td class="alg_r">3,00</td>
          </tr>
          <tr>
          <th>Wohnfläche: </th>
          <td class="alg_r">80,00 m²</td>
          </tr>
          <tr>
          <th>Bezugsfertig ab: </th>
          <td class="alg_r my_tp_dt">ab sofort</td>
          </tr>
          </tbody></table>
          </div>
          <div class="list_col span_wflist_data">
          <table class="tb-small-data fullw lightth"><tbody>
          <tr>
          <th>Etage: </th>
          <td class="alg_r">3 <span class="light">(von insg. 6)</span>
          </td>
          </tr>
          <tr>
          <th>Baujahr: </th>
          <td class="alg_r">2023</td>
          </tr>
          <tr>
          <th>Hauptenergieträger: </th>
          <td class="alg_r">Fernwärme</td>
          </tr>
          <tr>
          <th>Energieausweis: </th>
          <td class="alg_r">bedarfsausweis</td>
          </tr>

          </tbody></table>
          </div>
          </div>
          <p class="tb-flatdet-smaller alg_c"><span class="hackerl">Balkon/Loggia/Terrasse</span>
          <span class="hackerl">Aufzug</span>
          </p>
          <p class="alg_c"><small>Eine Wohnung der</small> <img src="https://inberlinwohnen.de/wp-content/themes/ibw/images/logos/howoge-small-grey.jpg" style="width:100%; max-width:100px; line-height:10px; vertical-align:middle;" alt=""></p>
          </div>
          </li>
          <li id="#{second_external_id}" class="tb-merkflat ipg">
          <h3 id="mfh7654321"><span><span class="_tb_left"><strong>4</strong> Zimmer, <strong>85,00</strong>  m², <strong>1.234,00</strong>  € | Andere Straße 60, Woanders</span><span class="_tb_right"><a title="Balkon/Terasse" class="icon nohand2 balkon_loggia_terrasse"></a>
          <a title="Aufzug" class="icon aufzug nohand2"></a>
          <a title="Gäste-WC" class="icon gaeste_wc nohand2"></a>
          </span></span></h3>
          <div id="mfd7654321" class="tb-merkdetails">
          <h2>4-Zimmer-Wohnung mit moderner offener Küche</h2>
          <div class="section group">
          <div class="list_col span_wflist_image">
          <figure class="flat-image wide" style="background-image:url(https://inberlinwohnen.de/wp-content/themes/ibw/images/flat-dummy.jpg);">
          <img src="https://inberlinwohnen.de/wp-content/themes/ibw/images/square-image.gif" alt="">
          </figure>
          <a title="Die detailierte Wohnungsanzeige öffnet in einem neuen Fenster" class="org-but" href="/dsa::987/654/321.html" target="_blank">Alle Details</a>
          </div>
          <div class="list_col span_wflist_data">
          <table class="tb-small-data fullw"><tbody>
          <tr>
          <th>Adresse: </th>
          <td class="alg_r"><a title="Auf Karte anzeigen" class="map-but" href="#" onclick="openOverlay('nmap-7654321','de'); return false;">Andere Straße 60, Woanders</a></td>
          </tr>
          <tr>
          <th>Zimmeranzahl: </th>
          <td class="alg_r">4,00</td>
          </tr>
          <tr>
          <th>Wohnfläche: </th>
          <td class="alg_r">85,00 m²</td>
          </tr>
          <tr>
          <th>Bezugsfertig ab: </th>
          <td class="alg_r my_tp_dt">ab sofort</td>
          </tr>
          </tbody></table>
          </div>
          <div class="list_col span_wflist_data">
          <table class="tb-small-data fullw lightth"><tbody>
          <tr>
          <th>Etage: </th>
          <td class="alg_r">4 <span class="light">(von insg. 6)</span>
          </td>
          </tr>
          <tr>
          <th>Baujahr: </th>
          <td class="alg_r">2023</td>
          </tr>
          <tr>
          <th>Hauptenergieträger: </th>
          <td class="alg_r">Fernwärme</td>
          </tr>
          <tr>
          <th>Energieausweis: </th>
          <td class="alg_r">bedarfsausweis</td>
          </tr>

          </tbody></table>
          </div>
          </div>
          <p class="tb-flatdet-smaller alg_c"><span class="hackerl">Balkon/Loggia/Terrasse</span>
          <span class="hackerl">Aufzug</span>
          <span class="hackerl">Gäste-WC</span>
          </p>
          <p class="alg_c"><small>Eine Wohnung der</small> <img src="https://inberlinwohnen.de/wp-content/themes/ibw/images/logos/howoge-small-grey.jpg" style="width:100%; max-width:100px; line-height:10px; vertical-align:middle;" alt=""></p>
          </div>
          </li>
        HTML
      )
    end
  end
end
