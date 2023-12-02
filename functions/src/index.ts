import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
// const db = admin.firestore();

exports.irrigacao = functions.firestore.document('usuarios/{userId}/fazendas/{fazendaId}/talhoes/{talhaoId}/safras/{safraId}').onUpdate(async (change, context) => {
  const afterData = change.after.data();
  const previousData = change.before.data();

  if (afterData.irrigation != undefined && afterData.irrigation == previousData.irrigation) {
    return null;
  }

  var parameters = [
    afterData.ano,
    afterData.sow_day,
    afterData.days_since_sow,
    afterData.latitude,
    afterData.longitude,
    afterData.vget4_day,
    afterData.flower_day,
    afterData.grain_fill_day,
    afterData.matur_day,
    afterData.field_cap_1,
    afterData.field_cap_2,
    afterData.field_cap_3,
    afterData.perm_with_point_1,
    afterData.perm_with_point_2,
    afterData.perm_with_point_3,
    afterData.sow_root_prof,
    afterData.veget4_root_prof,
    afterData.flower_root_prof,
    afterData.grain_fill_root_prof,
    afterData.matur_root_prof,
    afterData.sow_cult_coeff,
    afterData.veget4_cult_coeff,
    afterData.flower_cult_coeff,
    afterData.grain_fill_cult_coeff,
    afterData.matur_cult_coeff,
    afterData.pivot_cap,
    afterData.sow_pivot_optimal_limit,
    afterData.veget4_pivot_optimal_limit,
    afterData.flower_pivot_optimal_limit,
    afterData.grain_pivot_optimal_limit,
    afterData.matur_pivot_optimal_limit,
    afterData.sow_critical_limit,
    afterData.veget4_critical_limit,
    afterData.flower_critical_limit,
    afterData.grain_critical_limit,
    afterData.matur_critical_limit
  ];

  interface Dados_Meteorologicos {
    year: { [index: number]: number };
    day_of_year: { [index: number]: number };
    min_temp: { [index: number]: number };
    max_temp: { [index: number]: number };
    mean_temp: { [index: number]: number };
    umid: { [index: number]: number };
    wind: { [index: number]: number };
    rad: { [index: number]: number };
    rain: { [index: number]: number };
    irrigated: { [index: number]: number };
  }

  interface Retorno {
    day_of_year: number;
    irrigation: number;
    deficit: number;
    available_water: number;
    rain: number;
    irrigated: boolean
  }

  var dados_brutos = afterData.dados_meteorologicos as 
  { 
    year: number, 
    day_of_year: number, 
    min_temp: number, 
    max_temp: number, 
    mean_temp: number, 
    umid: number, 
    wind: number, 
    rad: number, 
    rain: number, 
    irrigated: number
  }[]

  var dados_irrigados = afterData.irrigation as {
    available_water: number,
    day_of_year: number,
    deficit: number,
    irrigation: number,
    rain: number,
    irrigated: boolean
  }[]

  var dados: Dados_Meteorologicos = {
    year: { [0]: 0 },
    day_of_year: { [0]: 0 },
    min_temp: { [0]: 0 },
    max_temp: { [0]: 0 },
    mean_temp: { [0]: 0 },
    umid: { [0]: 0 },
    wind: { [0]: 0 },
    rad: { [0]: 0 },
    rain: { [0]: 0 },
    irrigated: { [0]: 0 },
  }

  for (let i = 0; i < dados_brutos.length; i++) {
    dados.year[i] = dados_brutos[i]['year'];
    dados.day_of_year[i] = dados_brutos[i]['day_of_year'];
    dados.min_temp[i] = dados_brutos[i]['min_temp'];
    dados.max_temp[i] = dados_brutos[i]['max_temp'];
    dados.mean_temp[i] = dados_brutos[i]['mean_temp'];
    dados.umid[i] = dados_brutos[i]['umid'];
    dados.wind[i] = dados_brutos[i]['wind'];
    dados.rad[i] = dados_brutos[i]['rad'];
    dados.rain[i] = dados_brutos[i]['rain'];
    dados.irrigated[i] = dados_brutos[i]['irrigated'];
  }
  var data = {
    "parameters": parameters,
    "meteorological_data": dados
  }

  interface MyInterface {
    [index: number]: number ;
  }

  const vetor_retorno: Retorno[] = []

  try {
    const response = await fetch('https://api.cropsteam.com/watercrop/staging/crop', {
      method: 'POST',
      body: JSON.stringify(data),
      headers: {
        'Content-Type': 'application/json',
      },
    });

    if (!response.ok) {
      throw new Error(`Error! status: ${response.status}`);
    }

    const result = (await response.json());

    var resultado: MyInterface = result['result']['day_of_year'] as MyInterface

    let j = 0
    for (let i = (Object.values(resultado).length)-1; i >= 0; i--) {
      vetor_retorno.push({
        day_of_year: result['result']['day_of_year'][i],
        irrigation: dados_irrigados != undefined && dados_irrigados[j]['irrigated'] ? dados_irrigados[j]['irrigation'] : result['result']['irrigation'][i],
        deficit: result['result']['deficit'][i],
        available_water: result['result']['available_water'][i],
        rain: dados_irrigados == undefined ? dados_brutos[i]['rain'] : dados_irrigados[j]['rain'],
        irrigated: dados_irrigados == undefined ? false : dados_irrigados[j]['irrigated']
      })
      j++
    }

  } catch (error) {
    if (error instanceof Error) {
      console.log('error message: ', error.message);
      return error.message;
    } else {
      console.log('unexpected error: ', error);
      return 'An unexpected error occurred';
    }
  }
  
  return await change.after.ref.update({
    irrigation: vetor_retorno}) 
});