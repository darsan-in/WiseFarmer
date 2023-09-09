import keras
from keras.utils import load_img
from keras.utils import img_to_array
import numpy as np
from PIL import Image
import tensorflow as tf

def predictDisease(leafname, file):
    #loading models
    potatomodel = keras.models.load_model('potato.h5')
    maizemodel= keras.models.load_model('maize_corn.h5')
    ricemodel = keras.models.load_model('rice.h5')
    tomatomodel = keras.models.load_model('tomatomodel.h5')

    #open the image
    img = Image.open(file)

    #image conversion
    image = np.asarray(img)
    a= tf.convert_to_tensor(image)
    image=a.numpy().astype("uint8")
    image.resize(1, 256, 256, 3)
    b=np.array(image)

    #category
    potato_class=['Early Blight','Healthy','Late Blight']
    maize_class=['Blight','Common-Rust','Gray_leafname_Spot','Healthy']
    rice_class = ['Bacterial leafname Blight','Brown Spot','leafname Smut']
    tomato_class = ['Bacteria Spot Disease', 'Early Blight Disease', 'Healthy and Fresh', 'Late Blight Disease', 'leafname Mold Disease', 'Septoria leafname Spot Disease', 'Target Spot Disease', 'Tomoato Yellow leafname Curl Virus Disease', 'Tomato Mosaic Virus Disease', 'Two Spotted Spider Mite Disease']

    if (leafname == 'potato'):
        prediction = potato_class[np.argmax(potatomodel.predict(b)[0])]
        
        if (prediction == "Early Blight"):
            return ["Potato - Early Blight", 'Early blight can be minimized by maintaining optimum growing conditions, including proper fertilization, irrigation, and management of other pests. Grow later maturing, longer season varieties. Fungicide application is justified only when the disease is initiated early enough to cause economic loss']
        
        if (prediction == "Late Blight"):
            return ["Potato - Late Blight", 'Late blight is controlled by eliminating cull piles and volunteer potatoes, using proper harvesting and storage practices, and applying fungicides when necessary. Air drainage to facilitate the drying of foliage each day is important. Under marginal conditions, overhead sprinkler irrigation can favor late blight; in Tule Lake under solid set sprinklers, conditions conducive to late blight development are enhanced by day time irrigation but not night time irrigation.']

    elif (leafname == 'maize'):
        prediction = maize_class[np.argmax(maizemodel.predict(b)[0])]
        
        if (prediction == 'Blight'):
            return ['Maize - Blight', 'Always consider an integrated approach with preventive measures together with biological control measures if available. Fungicide application can effectively control the disease when applied at the right time. Consider an application only after weighting the development of the disease against the potential yield loss, the weather forecast and the growth stage of the plant.  Any fast-acting, broad spectrum product is recommended, for example mancozeb (2.5 g/l) at 8-10 days interval.']
        
        if (prediction == 'Common-Rust'):
            return ['Maize - Common-Rust', 'The best management practice is to use resistant corn hybrids. Fungicides can also be beneficial, especially if applied early when few pustules have appeared on the leaves.']
        
        if (prediction=='Gray_leafname_Spot'):
            return ['Maize - Gray_leafname_Spot', 'Disease management tactics include using resistant corn hybrids, conventional tillage where appropriate, and crop rotation. Foliar fungicides can be effective if economically warranted. Typically they are only profitable on susceptible inbreds or susceptible hybrids under a combination of high risk conditions with high yield potential, prolonged humid conditions, and evidence of disease development.']

    elif (leafname == 'rice'):
        prediction = rice_class[np.argmax(ricemodel.predict(b)[0])]

        if (prediction == 'Bacterial leafname Blight'):
            return ['Rice - Bacterial leafname Blight', 'Use balanced fertilizer, Avoid the use of excessive nitrogen. Split nitrogen applications, Avoid top dressing urea after wind, rain and hailstorms, Use two-thirds MOP at basal and apply the rest with the third top dress of urea, Burn infected crop residues after harvesting in severe cases, Use disease free seed (without spots), Apply water before uprooting seedlings in seed bed, Use tray/nursery box seedling to avoid root injury.']

        if (prediction == 'Brown Spot'):
            return ['Rice - Brown Spot', 'Use resistant varieties. Contact your local agriculture office for up-to-date lists of varieties available. Keep fields clean. Remove weeds and weedy rice in the field and nearby areas to remove alternate hosts that allow the fungus to survive and infect new rice crops. Use balanced nutrients; make sure that adequate potassium is used. If narrow brown spot poses a risk to the field, spray propiconazole at booting to heading stages.']

        if (prediction == 'leafname Smut'):
            return ['Rice - Smut', 'In most situations, there is no major loss caused by rice leafname smut, so treatment isn’t usually given. However, it can be a good idea to use good general management practices to prevent the infection or keep it in check, and to keep plants healthy overall. As with many other fungal infections, this one is spread by infected plant material in the soil. When healthy leaves contact the water or ground with old diseased leaves, they can become infected. Cleaning up debris at the end of each growing season can prevent spread of leafname smut.']

    elif (leafname == 'tomato'):
        test_image = load_img(file, target_size = (128, 128)) # load image 
        test_image = img_to_array(test_image)/255 # convert image to np array and normalize
        test_image = np.expand_dims(test_image, axis = 0) # change dimention 3D to 4D
        result = tomatomodel.predict(test_image) # predict diseased palnt or not
        prediction = np.argmax(result, axis=1)

        if prediction==0:
            return ["Tomato - Bacteria Spot Disease", 'Copper fungicides are the most commonly recommended treatment for bacterial leafname spot. Use copper fungicide as a preventive measure after you’ve planted your seeds but before you’ve moved the plants into their permanent homes. You can use copper fungicide spray before or after a rain, but don’t treat with copper fungicide while it is raining. If you’re seeing signs of bacterial leafname spot, spray with copper fungicide for a seven- to 10-day period, then spray again for one week after plants are moved into the field. Perform maintenance treatments every 10 days in dry weather and every five to seven days in rainy weather.']
            
        elif prediction==1:
            return ["Tomato - Early Blight Disease", 'Tomatoes that have early blight require immediate attention before the disease takes over the plants. Thoroughly spray the plant (bottoms of leaves also) with Bonide Liquid Copper Fungicide concentrate or Bonide Tomato & Vegetable. Both of these treatments are organic']
                
        elif prediction==2:
            return ["Tomato - Healthy and Fresh", 'There is no disease on the Tomato leafname']
                
        elif prediction==3:
            return ["Tomato - Late Blight Disease", 'Tomatoes that have early blight require immediate attention before the disease takes over the plants. Thoroughly spray the plant (bottoms of leaves also) with Bonide Liquid Copper Fungicide concentrate or Bonide Tomato & Vegetable. Both of these treatments are organic']

        elif prediction==4:
            return ["Tomato - leafname Mold Disease", 'Use drip irrigation and avoid watering foliage. Use a stake, strings, or prune the plant to keep it upstanding and increase airflow in and around it. Remove and destroy (burn) all plants debris after the harvest']
                
        elif prediction==5:
            return ["Tomato - Septoria leafname Spot Disease", 'Remove infected leaves immediately, and be sure to wash your hands and pruners thoroughly before working with uninfected plants. Fungicides containing either copper or potassium bicarbonate will help prevent the spreading of the disease. Begin spraying as soon as the first symptoms appear and follow the label directions for continued management. While chemical options are not ideal, they may be the only option for controlling advanced infections. One of the least toxic and most effective is chlorothalonil (sold under the names Fungonil and Daconil).']
                
        elif prediction==6:
            return ["Tomato - Target Spot Disease", 'Many fungicides are registered to control of target spot on tomatoes. Growers should consult regional disease management guides for recommended products. Products containing chlorothalonil, mancozeb, and copper oxychloride have been shown to provide good control of target spot in research trials']
                
        elif prediction==7:
            return ["Tomato - Tomoato Yellow leafname Curl Virus Disease", 'Inspect plants for whitefly infestations two times per week. If whiteflies are beginning to appear, spray with azadirachtin (Neem), pyrethrin or insecticidal soap. For more effective control, it is recommended that at least two of the above insecticides be rotated at each spraying.']
        
        elif prediction==8:
            return ["Tomato - Tomato Mosaic Virus Disease", 'There are no cures for viral diseases such as mosaic once a plant is infected. As a result, every effort should be made to prevent the disease from entering your garden.']
                
        elif prediction==9:
            return ["Tomato - Two Spotted Spider Mite Disease", 'Selective products which have worked well in the field include: bifenazate (Acramite): Group UN, a long residual nerve poison, abamectin (Agri-Mek): Group 6, derived from a soil bacterium spirotetramat (Movento): Group 23, mainly affects immature stages, spiromesifen (Oberon 2SC): Group 23, mainly affects immature stages.']