ifeq ($(CLUSTER), x64_linux)
    ITK_SRC_DIR	= $(OPEN_SOFTWARE_SOURCES_TOPLEVEL)/itk-4.5.2
    ITK_BIN_DIR = $(OPEN_SOFTWARE_BINARIES_TOPLEVEL)/itk-4.5.2
    ITK_DEFS = -D ITK_IO_FACTORY_REGISTER_MANAGER
    ITK_INCDIRS = \
-I$(ITK_BIN_DIR)/Examples/ITKIOFactoryRegistration \
-I$(ITK_SRC_DIR)/Modules/Segmentation/Watersheds/include \
-I$(ITK_SRC_DIR)/Modules/Bridge/VtkGlue/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/Voronoi/include \
-I$(ITK_SRC_DIR)/Modules/Video/IO/include \
-I$(ITK_SRC_DIR)/Modules/Video/Filtering/include \
-I$(ITK_SRC_DIR)/Modules/Video/Core/include \
-I$(ITK_SRC_DIR)/Modules/Bridge/VTK/include \
-I$(ITK_SRC_DIR)/Modules/Core/TestKernel/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/SpatialFunction/include \
-I$(ITK_SRC_DIR)/Modules/Registration/RegistrationMethodsv4/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/RegionGrowing/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/QuadEdgeMeshFiltering/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/NeuralNetworks/include \
-I$(ITK_SRC_DIR)/Modules/Registration/Metricsv4/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/Optimizersv4/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/MarkovRandomFieldsClassifiers/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/LevelSetsv4/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/LabelVoting/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/KLMRegionGrowing/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageFusion/include \
-I$(ITK_SRC_DIR)/Modules/IO/VTK/include \
-I$(ITK_SRC_DIR)/Modules/IO/TransformMatlab/include \
-I$(ITK_SRC_DIR)/Modules/IO/TransformInsightLegacy/include \
-I$(ITK_SRC_DIR)/Modules/IO/TransformHDF5/include \
-I$(ITK_SRC_DIR)/Modules/IO/TransformBase/include \
-I$(ITK_SRC_DIR)/Modules/IO/Stimulate/include \
-I$(ITK_SRC_DIR)/Modules/IO/Siemens/include \
-I$(ITK_SRC_DIR)/Modules/IO/RAW/include \
-I$(ITK_SRC_DIR)/Modules/IO/PNG/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/PNG/src \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/PNG/src \
-I$(ITK_SRC_DIR)/Modules/IO/NRRD/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/NrrdIO/src/NrrdIO \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/NrrdIO/src/NrrdIO \
-I$(ITK_SRC_DIR)/Modules/IO/NIFTI/include \
-I$(ITK_SRC_DIR)/Modules/IO/Meta/include \
-I$(ITK_SRC_DIR)/Modules/IO/Mesh/include \
-I$(ITK_SRC_DIR)/Modules/IO/MRC/include \
-I$(ITK_SRC_DIR)/Modules/IO/LSM/include \
-I$(ITK_SRC_DIR)/Modules/IO/TIFF/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/TIFF/src \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/TIFF/src/itktiff \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/TIFF/src \
-I$(ITK_SRC_DIR)/Modules/IO/JPEG/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/JPEG/src \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/JPEG/src \
-I$(ITK_SRC_DIR)/Modules/IO/HDF5/include \
-I$(ITK_SRC_DIR)/Modules/IO/GIPL/include \
-I$(ITK_SRC_DIR)/Modules/IO/GE/include \
-I$(ITK_SRC_DIR)/Modules/IO/IPL/include \
-I$(ITK_SRC_DIR)/Modules/IO/GDCM/include \
-I$(ITK_SRC_DIR)/Modules/IO/CSV/include \
-I$(ITK_SRC_DIR)/Modules/IO/BioRad/include \
-I$(ITK_SRC_DIR)/Modules/IO/BMP/include \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/HDF5/src \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/HDF5/src \
-I$(ITK_SRC_DIR)/Modules/Filtering/GPUThresholding/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/GPUSmoothing/include \
-I$(ITK_SRC_DIR)/Modules/Registration/GPUPDEDeformable/include \
-I$(ITK_SRC_DIR)/Modules/Registration/GPUCommon/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/GPUImageFilterBase/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/GPUAnisotropicSmoothing/include \
-I$(ITK_SRC_DIR)/Modules/Core/GPUFiniteDifference/include \
-I$(ITK_SRC_DIR)/Modules/Core/GPUCommon/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GIFTI/src/gifticlib \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/NIFTI/src/nifti/znzlib \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/NIFTI/src/nifti/niftilib \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/DataStructureAndEncodingDefinition \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/MessageExchangeDefinition \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/InformationObjectDefinition \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/Common \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/DataDictionary \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/MediaStorageAndFileFormat \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/GDCM/src/gdcm/Source/Common \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/GDCM \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/OpenJPEG/src/openjpeg \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/OpenJPEG/src/openjpeg \
-I$(ITK_SRC_DIR)/Modules/Registration/FEM/include \
-I$(ITK_SRC_DIR)/Modules/Registration/PDEDeformable/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/FEM/include \
-I$(ITK_SRC_DIR)/Modules/Registration/Common/include \
-I$(ITK_SRC_DIR)/Modules/IO/SpatialObjects/include \
-I$(ITK_SRC_DIR)/Modules/IO/XML/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/Expat/src/expat \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/Expat/src/expat \
-I$(ITK_SRC_DIR)/Modules/Numerics/Eigen/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/DisplacementField/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/DiffusionTensorImage/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/Denoising/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/DeformableMesh/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/Deconvolution/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/DICOMParser/src/DICOMParser \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/DICOMParser/src/DICOMParser \
-I$(ITK_SRC_DIR)/Modules/Filtering/Convolution/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/FFT/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/Colormap/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/Classifiers/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/BioCell/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/BiasCorrection/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/Polynomials/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/AntiAlias/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/LevelSets/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/SignedDistanceFunction/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/Optimizers/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageFeature/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageSources/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageGradient/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/Smoothing/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageCompare/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/FastMarching/include \
-I$(ITK_SRC_DIR)/Modules/Core/QuadEdgeMesh/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/DistanceMap/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/NarrowBand/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/BinaryMathematicalMorphology/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/LabelMap/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/MathematicalMorphology/include \
-I$(ITK_SRC_DIR)/Modules/Segmentation/ConnectedComponents/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/Thresholding/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageLabel/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageIntensity/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/Path/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageStatistics/include \
-I$(ITK_SRC_DIR)/Modules/Core/SpatialObjects/include \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/MetaIO/src/MetaIO \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/MetaIO/src/MetaIO \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/ZLIB/src \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/ZLIB/src \
-I$(ITK_SRC_DIR)/Modules/Core/Mesh/include \
-I$(ITK_SRC_DIR)/Modules/IO/ImageBase/include \
-I$(ITK_BIN_DIR)/Modules/IO/ImageBase \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageCompose/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/AnisotropicSmoothing/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageGrid/include \
-I$(ITK_SRC_DIR)/Modules/Core/ImageFunction/include \
-I$(ITK_SRC_DIR)/Modules/Core/Transform/include \
-I$(ITK_SRC_DIR)/Modules/Numerics/Statistics/include \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/Netlib \
-I$(ITK_SRC_DIR)/Modules/Core/ImageAdaptors/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/CurvatureFlow/include \
-I$(ITK_SRC_DIR)/Modules/Filtering/ImageFilterBase/include \
-I$(ITK_SRC_DIR)/Modules/Core/FiniteDifference/include \
-I$(ITK_SRC_DIR)/Modules/Core/Common/include \
-I$(ITK_BIN_DIR)/Modules/Core/Common \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/VNLInstantiation/include \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/VNL/src/vxl/core \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/VNL/src/vxl/vcl \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/VNL/src/vxl/v3p/netlib \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/VNL/src/vxl/core \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/VNL/src/vxl/vcl \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/VNL/src/vxl/v3p/netlib \
-I$(ITK_BIN_DIR)/Modules/ThirdParty/KWSys/src \
-I$(ITK_SRC_DIR)/Modules/ThirdParty/DoubleConversion/src/double-conversion

   ITK_LIBDIRS = $(ITK_BIN_DIR)/lib
   ITK_LIBS =    -L$(ITK_LIBDIRS) \
                            -litkgdcmuuid-4.5     -lITKIOMeta-4.5                    -lITKKLMRegionGrowing-4.5  -litktestlib-4.5 \
-lITKBiasCorrection-4.5     -lITKgiftiio-4.5      -lITKIOMRC-4.5                     -lITKLabelMap-4.5          -litktiff-4.5 \
-lITKBioCell-4.5            -litkhdf5_cpp-4.5     -lITKIONIFTI-4.5                   -lITKMesh-4.5              -litkv3p_lsqr-4.5 \
-lITKCommon-4.5             -litkhdf5-4.5         -lITKIONRRD-4.5                    -lITKMetaIO-4.5            -litkv3p_netlib-4.5 \
-lITKDICOMParser-4.5        -lITKIOBioRad-4.5     -lITKIOPNG-4.5                     -litkNetlibSlatec-4.5      -litkvcl-4.5 \
-litkdouble-conversion-4.5  -lITKIOBMP-4.5        -lITKIOSiemens-4.5                 -lITKniftiio-4.5           -lITKVideoCore-4.5 \
-lITKEXPAT-4.5              -lITKIOCSV-4.5        -lITKIOSpatialObjects-4.5          -lITKNrrdIO-4.5            -lITKVideoIO-4.5 \
-lITKFEM-4.5                -lITKIOGDCM-4.5       -lITKIOStimulate-4.5               -litkopenjpeg-4.5          -litkvnl_algo-4.5 \
-litkgdcmCommon-4.5         -lITKIOGE-4.5         -lITKIOTIFF-4.5                    -lITKOptimizers-4.5        -litkvnl-4.5 \
-litkgdcmDICT-4.5           -lITKIOGIPL-4.5       -lITKIOTransformBase-4.5           -lITKPath-4.5              -lITKVNLInstantiation-4.5 \
-litkgdcmDSED-4.5           -lITKIOHDF5-4.5       -lITKIOTransformHDF5-4.5           -litkpng-4.5               -lITKVTK-4.5 \
-litkgdcmIOD-4.5            -lITKIOImageBase-4.5  -lITKIOTransformInsightLegacy-4.5  -lITKPolynomials-4.5       -lITKVtkGlue-4.5 \
-litkgdcmjpeg12-4.5         -lITKIOIPL-4.5        -lITKIOTransformMatlab-4.5         -lITKQuadEdgeMesh-4.5      -lITKWatersheds-4.5 \
-litkgdcmjpeg16-4.5         -lITKIOJPEG-4.5       -lITKIOVTK-4.5                     -lITKSpatialObjects-4.5    -litkzlib-4.5 \
-litkgdcmjpeg8-4.5          -lITKIOLSM-4.5        -lITKIOXML-4.5                     -lITKStatistics-4.5        -lITKznz-4.5 \
-litkgdcmMSFF-4.5           -lITKIOMesh-4.5       -litkjpeg-4.5                      -litksys-4.5

endif
